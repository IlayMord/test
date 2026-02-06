**Terraform Fundamentals**

**What is Terraform and how does it differ from other IaC tools?**
Terraform is an infrastructure as code tool that lets us create and manage infrastructure with code. It is different from many other IaC tools because it supports many cloud providers with the same workflow.

**Explain Terraform's declarative nature and state management.**
Terraform is declarative, so we write the final state we want and not all the steps. Terraform uses a state file to track what already exists and compare it to the configuration.

**What is the purpose of the Terraform provider?**
A provider is a plugin that lets Terraform talk to external APIs like AWS. It translates Terraform code into API calls to create, update and delete resources.

**How does Terraform handle dependency resolution?**
Terraform builds a dependency graph from resource references and applies resources in the correct order. If needed, we can also use depends_on for explicit dependency.

**What are the key components of a Terraform configuration file?**
The main components are terraform block, provider block, resource block, variable block, output block and module block. Data sources and locals are also common.

**State Management & Backend Configuration**

**Explain the difference between terraform refresh, terraform plan, and terraform apply.**
Terraform refresh updates state from real infrastructure. Terraform plan shows what changes will happen. Terraform apply runs the changes and updates infrastructure and state.

**What is the difference between local and remote backends?**
Local backend stores state on the local machine. Remote backend stores state in shared storage like S3 so teams can work together safely.

**How can you prevent state corruption when multiple engineers work on the same infrastructure?**
Use remote backend with state locking. In AWS a common setup is S3 for state and DynamoDB for lock.

**Terraform Modules & Reusability**

**What are the benefits of using Terraform modules?**
Modules help us reuse code, keep it organized, and avoid duplicate code. They also make maintenance easier because we update logic in one place.

**Explain how to pass variables to a Terraform module.**
We pass values in the module block in root configuration. Inside the module, variables are defined in variables.tf and then used in resources.

**What is the difference between count and for_each?**
Count creates resources by index and is good for similar resources. For_each creates resources by key and is better when each resource is unique and more stable when order changes.

**How do you source a module from a Git repository?**
We use the source argument in module block with a git URL, and usually add ref to pin a specific version.

**Terraform with AWS**

**How do you create an EC2 instance with Terraform?**
First configure AWS provider, then define aws_instance with required fields like AMI and instance type, then run terraform init, terraform plan and terraform apply.

**What are the required fields for defining a VPC in Terraform?**
The main required argument is cidr_block, because it defines the VPC IP range.

**Explain how Terraform manages IAM policies in AWS.**
Terraform manages IAM by defining IAM resources as code like aws_iam_policy and aws_iam_role, then it creates, updates or deletes them based on plan and state.

**How do you use Terraform to provision and attach an Elastic Load Balancer?**
You create the load balancer, target group and listener, then register instances to the target group or attach an autoscaling group. Terraform handles dependency order automatically.

**Debugging & Error Handling**

**What does the terraform validate command do?**
Terraform validate checks if the configuration is syntactically valid and internally consistent. It does not create resources.

**How can you debug Terraform errors effectively?**
Read the CLI error carefully, run terraform validate and terraform plan, and check provider settings, credentials, variable values and resource references. If needed, use TF_LOG=DEBUG.

**What is Terraform’s ignore_changes lifecycle policy used for?**
Ignore_changes tells Terraform to ignore updates on specific attributes so Terraform will not try to change them on apply.

**How do you import existing AWS infrastructure into Terraform?**
First define the resource in Terraform code, then run terraform import to bring the real resource into state. After that run plan and align the code with the imported resource.
