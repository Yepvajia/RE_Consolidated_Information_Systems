# HI WELCOME TO ODYSSEY WEEK 7 : Offer Services on the Internet

## THIS IS THE README FOR THE GRAPHQL 

System Requirements:
VSCODE
Ruby On Rails:
Ruby: ruby 2.7
Rails: Rails 5.2.8

Gem added for Graphql:

`-graphql`

`-graphql-rails`

Run bundle install in the ubuntu terminal now you are ready to test the queries:
    
Go to this url: https://zacom.za.com/graphiql

To get the address of the building, the beginning and the end of the intervention:

Run : 

```
query{
  buildingtype{
    addressId
    interventionForBuilding {
      startDate
      endDate
    }
  }
}
```

To get the customer information and the list of interventions:

Run:

```
query{
  customertype{
    addressId
    interventionelevator {
      buildingId
    }
    interventionelevator2building {
      id
      addressId
    }
  }
}
```

To get all interventions carried out by a specified employee with the buildings associated with these interventions:

Run:

```
query{
  factinterventiontype(employeeId: 5){
    employeeId
    buildingId
    buildingintervention{
      addressId
    }
  }
}
```
