### 1. List (`list`)

A list is an ordered sequence of values. The critical constraint is that every element in the list must be of the same data type (e.g., all strings or all numbers).

* **Best For:** Grouping identical items where order matters or where you index items by position.
* **Looping:** Used with `count` or converted using `toset()` for `for_each`.

```hcl
variable "availability_zones" {
  type    = list(string)
  default = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

# Accessing a value
output "first_az" {
  value = var.availability_zones[0]
}

```

---

### 2. Map (`map`)

A map is a collection of key-value pairs where the keys are always strings, and all values must share the exact same data type.

* **Best For:** Simple lookups based on a lookup key (like environment names or regions).
* **Looping:** Pairs perfectly with `for_each` out of the box because every entry natively has a unique string key.

```hcl
variable "environment_ami_ids" {
  type = map(string)
  default = {
    dev  = "ami-0123456dev"
    prod = "ami-9876543prod"
  }
}

# Accessing a value
output "prod_ami" {
  value = var.environment_ami_ids["prod"] # Returns "ami-9876543prod"
}

```

---

### 3. Object (`object`)

An object is a structural type that acts like a strict schema. Unlike a map, each named attribute inside an object can have a completely different data type.

* **Best For:** Grouping related configuration settings that represent a single entity.
* **Key Feature:** Supports the `optional()` modifier, allowing you to set default values for attributes that a user might leave out.

```hcl
variable "db_configuration" {
  type = object({
    instance_class    = string
    allocated_storage = number
    multi_az          = optional(bool, false) # Defaults to false if omitted
  })

  default = {
    instance_class    = "db.t3.micro"
    allocated_storage = 20
  }
}

# Accessing a value (supports dot notation)
output "db_size" {
  value = var.db_configuration.allocated_storage
}

```