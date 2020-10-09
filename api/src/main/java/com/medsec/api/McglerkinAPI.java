package com.medsec.api;

import com.medsec.entity.Callum;

import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

@Path("/")
public class McglerkinAPI {

    @POST
    @Path("mcg/cal")
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    public Response testCallum(Callum c) {

        return Response.ok("deb").build();
    }
}
