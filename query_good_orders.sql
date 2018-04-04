Use Hoff;

select  ro.Id, ro.FirstCustomerActionId

    from directcrm.RetailOrders ro
        join directcrm.RetailOrderHistory roh on ro.Id = roh.OrderId
        join directcrm.RetailPurchaseHistory rph on roh.id = rph.OrderHistoryItemId
        join directcrm.RetailPurchaseStatuses rps on rph.StatusId = rps.Id

    where rps.CategorySystemName not in ('Returned','Cancelled','InCart') 
		and roh.IsCurrentOtherwiseNull = 1

    group by ro.Id, ro.FirstCustomerActionId

