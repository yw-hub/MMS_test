package com.medsec.api;

import com.medsec.entity.Resource;
import com.medsec.entity.ResourceFile;
import com.medsec.entity.User;
import com.medsec.filter.Secured;
import com.medsec.util.Database;
import com.medsec.util.UserRole;
import org.glassfish.jersey.server.JSONP;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.util.List;

/**
 * RESTful APIs for resources.
 *
 */
@Path("/")
public class ResourceAPI {

    @GET
    @Path("users/{uid}/resources")
    @Secured(UserRole.ADMIN)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listUserResources(
            @PathParam("uid") String uid) {

        List<Resource> results = retrieveUserResources(uid);

        return Response.ok(results).build();
    }

    @GET
    @Path("me/resources")
    @Secured(UserRole.PATIENT)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listMyResources(
            @Context SecurityContext sc) {

        String uid = sc.getUserPrincipal().getName();
        List<Resource> results = retrieveUserResources(uid);

        return Response.ok(results).build();
    }
    
    

    @GET
    @Path("resources/{resourceID}")
    @Secured
    @JSONP(queryParam = JSONP.DEFAULT_CALLBACK)
    @Produces({MediaType.APPLICATION_JSON})
    public Response getResource(
            @Context SecurityContext sc,
            @PathParam("resourceID") String id) {

        User requestUser = (User) sc.getUserPrincipal();
        UserRole requestRole = requestUser.getRole();
        String requestUid = requestUser.getId();

        Database db = new Database();
        Resource resource = db.getResource(id);

        if (resource == null)
            return Response.status(Response.Status.NOT_FOUND).entity(null).build();

        if (requestRole != UserRole.ADMIN && !requestUid.equals(resource.getUid()))
            return Response.status(Response.Status.FORBIDDEN).entity(null).build();

        return Response.ok(resource).build();
    }

    private List <Resource> retrieveUserResources(String uid) {

        Database db = new Database();
        return db.listUserResources(uid);
    }
    
    
    @GET
    @Path("users/{uid}/resourcefiles")
    @Secured(UserRole.ADMIN)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listUserResourcefiles(
            @PathParam("uid") String uid) {

        List<ResourceFile> results = retrieveUserResourceFiles(uid);

        return Response.ok(results).build();
    }
    
    @GET
    @Path("me/resourcefiles")
    @Secured(UserRole.PATIENT)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listMyResourcefiles(
            @Context SecurityContext sc) {

        String uid = sc.getUserPrincipal().getName();
        List<ResourceFile> results = retrieveUserResourceFiles(uid);

        return Response.ok(results).build();
    }
    
    
    @GET
    @Path("resourcefiles/{resourcefileID}")
    @Secured
    @JSONP(queryParam = JSONP.DEFAULT_CALLBACK)
    @Produces({MediaType.APPLICATION_JSON})
    public Response getResourceFile(
            @Context SecurityContext sc,
            @PathParam("resourcefileID") String id) {

        User requestUser = (User) sc.getUserPrincipal();
        UserRole requestRole = requestUser.getRole();
        String requestUid = requestUser.getId();

        Database db = new Database();
        ResourceFile resourcefile = db.selectRFileById(id);//

        if (resourcefile == null)
            return Response.status(Response.Status.NOT_FOUND).entity(null).build();

        if (requestRole != UserRole.ADMIN && !requestUid.equals(resourcefile.getUid()))//
            return Response.status(Response.Status.FORBIDDEN).entity(null).build();

        return Response.ok(resourcefile).build();
    }
    
    private List <ResourceFile> retrieveUserResourceFiles(String uid) {

        Database db = new Database();
        return db.listUserResourceFile(uid);//
    }


}
