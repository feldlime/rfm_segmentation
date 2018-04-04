Use Hoff;


select  c.Id
    ,DateDiff(dd, Max(ca.DateTimeUtc), GetDate())

    from directcrm.Customers c
        join directcrm.CustomerActions ca on c.Id = ca.CustomerId
        join	(select  ro.Id, ro.FirstCustomerActionId
					from directcrm.RetailOrders ro
						join directcrm.RetailOrderHistory roh on ro.Id = roh.OrderId
						join directcrm.RetailPurchaseHistory rph on roh.id = rph.OrderHistoryItemId
						join directcrm.RetailPurchaseStatuses rps on rph.StatusId = rps.Id
					where rps.CategorySystemName not in ('Returned','Cancelled','InCart') 
						and roh.IsCurrentOtherwiseNull = 1
					group by ro.Id, ro.FirstCustomerActionId
				) GoodOrders on ca.Id = GoodOrders.FirstCustomerActionId


    group by c.Id
	having DateDiff(dd, Max(ca.DateTimeUtc), GetDate()) between 100 and 300

    order by c.Id
