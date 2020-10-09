package com.medsec.api;

import com.google.gson.JsonObject;
import com.medsec.entity.Appointment;
import com.medsec.entity.User;
import com.medsec.filter.Secured;
import com.medsec.util.*;
import org.glassfish.jersey.server.JSONP;

import javax.ws.rs.*;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.SecurityContext;
import java.io.IOException;
import java.util.List;

/**
 * RESTful APIs for appointments.
 *
 */
@Path("/")
public class AppointmentAPI {

    @GET
    @Path("users/{uid}/appointments")
    @Secured(UserRole.ADMIN)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listUserAppointments(
            @PathParam("uid") String uid,
            @QueryParam("since") String since,
            @QueryParam("until") String until,
            @QueryParam("is_confirmed") Boolean is_confirmed) {

        List<Appointment> results = retrieveUserAppointments(uid, since, until, is_confirmed);

        return Response.ok(results).build();
    }


    @GET
    @Path("me/appointments")
    @Secured(UserRole.PATIENT)
    @JSONP(queryParam = "callback")
    @Produces(MediaType.APPLICATION_JSON)
    public Response listMyAppointments(
            @Context SecurityContext sc,
            @QueryParam("since") String since,
            @QueryParam("until") String until,
            @QueryParam("is_confirmed") Boolean is_confirmed) {

        String uid = sc.getUserPrincipal().getName();
        List<Appointment> results = retrieveUserAppointments(uid, since, until, is_confirmed);

        return Response.ok(results).build();
    }


    @GET
    @Path("appointments/{appointment_id}")
    @Secured
    @JSONP(queryParam = JSONP.DEFAULT_CALLBACK)
    @Produces({MediaType.APPLICATION_JSON})
    public Response getAppointment(
            @Context SecurityContext sc,
            @PathParam("appointment_id") String id) {

        User requestUser = (User) sc.getUserPrincipal();
        UserRole requestRole = requestUser.getRole();
        String requestUid = requestUser.getId();

        Database db = new Database();
        Appointment appointment = db.getAppointment(id);

        if (appointment == null)
            return Response.status(Response.Status.NOT_FOUND).entity(null).build();

        if (requestRole != UserRole.ADMIN && !requestUid.equals(appointment.getUid()))
            return Response.status(Response.Status.FORBIDDEN).entity(null).build();

        return Response.ok(appointment).build();
   }

    @POST
    @Path("appointments/{appointment_id}/confirm")
    @Secured
    @Produces(MediaType.APPLICATION_JSON)
    public Response confirmAppointment(
            @Context SecurityContext sc,
            @PathParam("appointment_id") String id) {

        User requestUser = (User)sc.getUserPrincipal();
        UserRole requestRole = requestUser.getRole();
        String requestUid = requestUser.getId();

        Database db = new Database(true);
        Appointment appointment = db.getAppointment(id);

        if (appointment == null)
            return Response.status(Response.Status.NOT_FOUND).entity(null).build();

        if (requestRole != UserRole.ADMIN && !requestUid.equals(appointment.getUid()))
            return Response.status(Response.Status.FORBIDDEN).entity(null).build();

        db.updateAppointmentStatus(id, AppointmentStatus.CONFIRMED);

        db.close();

        return Response.ok(new DefaultRespondEntity()).build();

    }

    @POST
    @Path("appointments/{appointment_id}/status")
    @Produces(MediaType.APPLICATION_JSON)
    public Response updateAppointmentStatus(
            @PathParam("appointment_id") String id,
            Appointment requestAppointment) {

        try{
            AppointmentStatus status = requestAppointment.getStatus();
            if (status == null)
                throw new ArgumentException();

            Database db = new Database();
            db.updateAppointmentStatus(id, status);

            return Response.ok(new DefaultRespondEntity()).build();

        } catch (ArgumentException e) {

            return Response
                    .status(Response.Status.BAD_REQUEST)
                    .entity(new DefaultRespondEntity(e.getMessage()))
                    .build();
        }

    }



    private List <Appointment> retrieveUserAppointments(String uid, String since, String until, Boolean is_confirmed) {

        AppointmentStatus status = null;
        if (is_confirmed != null)
            status = is_confirmed ? AppointmentStatus.CONFIRMED : AppointmentStatus.UNCONFIRMED;

        Database db = new Database();
        return db.listUserAppointments(uid, since, until, status);
    }


    @Path("/appointments/{appointment_id}/usernote")
    @Produces({MediaType.APPLICATION_JSON})
    public AppointmentNoteAPI appointmentNoteAPI(@PathParam("appointment_id") String id) {
        return new AppointmentNoteAPI(id);
    }

    public class AppointmentNoteAPI {
        String id;

        public AppointmentNoteAPI(String id) {
            this.id = id;
        }

        // TODO Redundant API method?
        @GET
        @Secured
        @JSONP(queryParam = JSONP.DEFAULT_CALLBACK)
        public Response getUserNote(@Context SecurityContext sc) {

            User requestUser = (User)sc.getUserPrincipal();
            UserRole requestRole = requestUser.getRole();
            String requestUid = requestUser.getId();

            Database db = new Database();
            Appointment appointment = db.getAppointment(id);

            if (appointment == null || appointment.getUser_note() == null)
                return Response.status(Response.Status.NOT_FOUND).entity(null).build();

            if (requestRole != UserRole.ADMIN && !requestUid.equals(appointment.getUid()))
                return Response.status(Response.Status.FORBIDDEN).entity(null).build();

            Appointment result = new Appointment()
                    .id(appointment.getId())
                    .user_note(appointment.getUser_note());

            return Response.ok(result).build();

        }

        @POST
        @Secured
        public Response updateUserNote(
                @Context SecurityContext sc,
                Appointment requestAppointment) {

            try {
                if (requestAppointment.getUser_note() == null)
                    throw new ArgumentException();

                User requestUser = (User) sc.getUserPrincipal();
                UserRole requestRole = requestUser.getRole();
                String requestUid = requestUser.getId();

                Database db = new Database(true);
                Appointment appointment = db.getAppointment(id);

                if (appointment == null)
                    return Response.status(Response.Status.NOT_FOUND).entity(null).build();

                if (requestRole != UserRole.ADMIN && !requestUid.equals(appointment.getUid()))
                    return Response.status(Response.Status.FORBIDDEN).entity(null).build();

                Appointment updatedAppointment = db.updateUserNote(id, requestAppointment.getUser_note());

                db.close();

                return Response.ok(updatedAppointment).build();

            } catch (ArgumentException e) {

                return Response
                        .status(Response.Status.BAD_REQUEST)
                        .entity(new DefaultRespondEntity(e.getMessage()))
                        .build();
            }
        }


        @DELETE
        @Secured
        public Response deleteUserNote(@Context SecurityContext sc) {

            User requestUser = (User)sc.getUserPrincipal();
            UserRole requestRole = requestUser.getRole();
            String requestUid = requestUser.getId();

            Database db = new Database(true);
            Appointment appointment = db.getAppointment(id);

            if (appointment == null)
                return Response.status(Response.Status.NOT_FOUND).entity(null).build();

            if (requestRole != UserRole.ADMIN && !requestUid.equals(appointment.getUid()))
                return Response.status(Response.Status.FORBIDDEN).entity(null).build();

            db.deleteUserNote(id);

            db.close();
            db.close();

            return Response.ok(new DefaultRespondEntity()).build();
        }


    }

}
