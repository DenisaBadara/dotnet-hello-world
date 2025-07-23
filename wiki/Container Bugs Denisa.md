# Container Bugs - Denisa

## Problems I encountered during the CONTAINERS assignment

Problem 1: I was using application_config in the azurerm_linux_web_app resource from main.tf, and I kept getting errors because of linux_fx.  
Solution: I replaced application_config with site_config and added application_stack. The error disappeared.

Problem 2: My pipeline had only two stages, one for Terraform and one for Build, Push and Deploy. It was hard to tell where things were going wrong and the logs were messy.  
Solution: I split the pipeline into three stages: Terraform Provisioning, Build and Push Docker Image, and Deploy to Azure App Service. It became much easier to debug.

Problem 3: Terraform Plan and Apply were failing because the state file was not synchronized. It said resources already existed, but when I tried importing them, Plan still didn’t work.  
Solution: I created a new tfstate, did the import only once, and then removed that step from the pipeline since the resources were already saved.

Problem 4: I canceled a pipeline run while Terraform was still provisioning, and that caused the tfstate to become locked.  
Solution: I asked Constantin to unlock it so I could continue.

Problem 5: Even after all the pipeline stages completed successfully, the app didn’t show anything when I clicked the link. I found out the Docker username and password variables were empty, and also that the app was running on port 8081, not 80.  
Solution: I tried to fix the port and gave AcrPull permissions, but nothing worked. In the end I just left the port as 8080 which matched the image.

Problem 6: I didn’t have permissions to set AcrPull role.  
Solution: I used the Container Registry username and password directly to log in, just to make it work.

Problem 7: At first, I hardcoded the username and password in main.tf, but I wanted to avoid that. I added them as pipeline variables and used them in the Apply and Destroy tasks using TF_VAR style, but they didn’t work.  
Solution: I switched to using -var instead.

Problem 8: Even with -var, the plan task was still failing because I had only added the variables to Apply and Destroy.  
Solution: I added the same variables to the Plan task and the pipeline finally worked.
