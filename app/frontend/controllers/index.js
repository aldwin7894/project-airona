import { Application } from "@hotwired/stimulus";
import { registerControllers } from "stimulus-vite-helpers";
import RailsNestedForm from "@stimulus-components/rails-nested-form";

const application = Application.start();
application.register("nested-form", RailsNestedForm);

const controllers = import.meta.glob("./**/*_controller.js");
registerControllers(application, controllers);
