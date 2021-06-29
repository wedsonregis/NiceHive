# NiceHive

## About The Project
There are many great templates available on GitHub, however, I didn't find one that really suit my needs so I created this enhanced one.

Here's why:
* Aggregate information from various Hiveos rigs
* Aggregate pool payments and earnings
* Charts and statistics of rigs in hiveos

Of course, no one template will serve all projects since your needs may be different. So I'll be adding more in the near future. You may also suggest changes by forking this repo and creating a pull request or opening an issue. Thanks to all the people have have contributed to expanding this template!

A list of commonly used resources that I find helpful are listed in the acknowledgements.

### Built With

This section should list any major frameworks that you built your project using. Leave any add-ons/plugins for the acknowledgements section. Here are a few examples.

 * [Teechart](http://www.teechart.net/product/vcl)
 * [RESTRequest4Delphi](https://github.com/viniciussanchez/RESTRequest4Delphi)
 * [JsonToDelphi](https://github.com/marlonnardi/JsonToDelphi)
 * [dataset-serialize](https://github.com/viniciussanchez/dataset-serialize)
 * [Coinbase](https://developers.coinbase.com/api/v2)
 * [Hiveos](https://app.swaggerhub.com/apis/HiveOS/public/2.1-beta)

<p align="center">
    <img src="https://raw.githubusercontent.com/wedsonregis/NiceHive/master/dashboard-01.PNG" alt="" width="29%" height="29%">
    <img src="https://raw.githubusercontent.com/wedsonregis/NiceHive/master/dashboard-02.PNG" alt="" width="29%" height="29%">
    <img src="https://raw.githubusercontent.com/wedsonregis/NiceHive/master/dashboard-03.PNG" alt="" width="29%" height="29%">
</p>



<!-- GETTING STARTED -->
## Getting Started

`pool.json` Pools configuration file
```json
 {
    "pool":[
    { 
      "id":0,
      "name":"Nanopool",
      "COIN":"ERG",
      "urlpool":"https://ergo.nanopool.org/api/v1",
      "expression":"%s/load_account/%s",
      "balance":"f|data.userParams.balance",
      "balance_unconfirmed":"f|data.userParams.balance_unconfirmed", 
      "min_payout": 5
    }
    ]
 }
``` 
### name
  * Name of pool
  
### COIN
  * Coin flag
  
### urlpool
  * Include pool API uri without endpoints
  
### expression
  * the expression must be assembled according to the api you want to consume, but two variables must be kept: "%s/load_account/%s"
  First %s refers to previously passed uri. The second %s preserves the wallet that will be passed in the flightsheet.json file.
  
### balance and balance_unconfirmed
  * Balance Before navigating jason's nodes we need to know what kind of data we are going to collect. 
  I prepared 3 parameters based on the calculation, you can try:

  1. "`f`|data.userParams.balance" (`f`) Float received from the "balance" pool: (0.574648347497753)
  2. "`i`|stats.balance" (`i`) Integr received from the "updatedAt" pool: (1624924815151)
  3. "`b`|result.balance" (`b`) bitcoin division integer received from the "balance" pool: (2748285944013025)
  
### min_payout
  * Setting the minimum payout for the progress bar




GetPool the GetPool Method needs to be improved or could be implemented.

```delphi
      begin
        st := LResponse.Content;
        JSonValue := TJSonObject.ParseJSONValue(st);
        // Balance
        if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'i')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1)) /
            1000000000
        else if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'b')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1)) /
            1000000000000000000
        else if (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 0) = 'f')
        then
          DashboardMain.Profitability := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance, 1));

        // Balance_Unconfirmed
        if ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed, 0)
          = 'i' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed,
            1)) / 1000000000
        else if ParseDelimite(Config.pool.Data[Config.poolId]
          .Balance_Unconfirmed, 0) = 'b' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId].Balance_Unconfirmed,
            1)) / 1000000000000000000
        else if ParseDelimite(Config.pool.Data[Config.poolId]
          .Balance_Unconfirmed, 0) = 'f' then
          DashboardMain.UnpaidAmount := JSonValue.GetValue<Double>
            (ParseDelimite(Config.pool.Data[Config.poolId]
            .Balance_Unconfirmed, 1));
        JSonValue.Free;
      end;
``` 


`flightsheet.json` flight sheet configuration file
```json
 {
    "flightsheet":
    [
        {
          "id":0,
          "coinid": 3,
          "wallet": "9fkEsioCXs11CbMoCzM8TCmRu2YanNBQYu8ZuTCypEgM9CqFox6",
          "poolid": 0,
          "acctive": false
        }
    ]
 }
``` 
