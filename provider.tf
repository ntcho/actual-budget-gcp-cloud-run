terraform { 
  cloud { 
    organization = "Actual-Budget-Personal" 

    workspaces { 
      name = "self" 
    } 
  } 
}