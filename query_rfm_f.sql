Use Hoff;


select top(1000) c.Id
    ,Count(ca.Id)

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

    order by c.Id