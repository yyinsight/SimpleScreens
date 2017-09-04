<#--
This software is in the public domain under CC0 1.0 Universal plus a Grant of Patent License.

To the extent possible under law, the author(s) have dedicated all
copyright and related and neighboring rights to this software to the
public domain worldwide. This software is distributed without any
warranty.

You should have received a copy of the CC0 Public Domain Dedication
along with this software (see the LICENSE.md file). If not, see
<http://creativecommons.org/publicdomain/zero/1.0/>.
-->
<#macro statsPanel title mainFormat valThis valLast valPrior valAvg chartList="">
<div class="panel panel-default"><div class="panel-body">
    <h5 class="text-center" style="margin-top:0;">${title}</h5>
    <div class="row"><div class="col-xs-6 text-right">
        <h4 class="text-primary">${ec.l10n.format(valThis, mainFormat)}</h4>
    </div><div class="col-xs-6">
        <div>
            <i class="glyphicon <#if (valThis < valLast)>glyphicon-triangle-bottom text-danger<#else>glyphicon-triangle-top text-success</#if>"></i>
            <span class="<#if (valThis < valLast)>text-danger<#else>text-success</#if>"><#if valLast != 0>${ec.l10n.format(((valThis - valLast)?abs/valLast)*100, '0')}<#else>0</#if>%</span>
            <span class="small">last</span>
        </div>
        <div>
            <i class="glyphicon <#if (valThis < valAvg)>glyphicon-triangle-bottom text-danger<#else>glyphicon-triangle-top text-success</#if>"></i>
            <span class="<#if (valThis < valAvg)>text-danger<#else>text-success</#if>"><#if valAvg != 0>${ec.l10n.format(((valThis - valAvg)?abs/valAvg)*100, '0')}<#else>0</#if>%</span>
            <span class="small">avg</span>
        </div>
    </div></div>
    <div class="row"><div class="col-xs-6 text-right">
        <h4 class="text-primary">${ec.l10n.format(valLast, mainFormat)}</h4>
    </div><div class="col-xs-6">
        <div>
            <i class="glyphicon <#if (valLast < valPrior)>glyphicon-triangle-bottom text-danger<#else>glyphicon-triangle-top text-success</#if>"></i>
            <span class="<#if (valLast < valPrior)>text-danger<#else>text-success</#if>"><#if valPrior != 0>${ec.l10n.format(((valLast - valPrior)?abs/valPrior)*100, '0')}<#else>0</#if>%</span>
            <span class="small">prev</span>
        </div>
        <div>
            <i class="glyphicon <#if (valLast < valAvg)>glyphicon-triangle-bottom text-danger<#else>glyphicon-triangle-top text-success</#if>"></i>
            <span class="<#if (valLast < valAvg)>text-danger<#else>text-success</#if>"><#if valAvg != 0>${ec.l10n.format(((valLast - valAvg)?abs/valAvg)*100, '0')}<#else>0</#if>%</span>
            <span class="small">avg</span>
        </div>
    </div></div>
    <#if chartList?has_content>
        <#assign chartId = title?replace(" ", "_") + "_Chart">
        <div class="chart-container" style="position:relative; height:90px; width:100%;"><canvas id="${chartId}"></canvas></div>
        <script>
            var ${chartId} = new Chart(document.getElementById("${chartId}"), { type: 'line',
                data: { labels:${Static["groovy.json.JsonOutput"].toJson(orderLabelList)},
                    datasets:[{backgroundColor: "rgba(49, 112, 143, 0.5)", borderColor: "rgba(49, 112, 143, 0.5)", fill: false,
                        data: ${Static["groovy.json.JsonOutput"].toJson(chartList)} }] },
                options: { legend:{display:false}, scales:{ xAxes:[{display:false}] }, maintainAspectRatio:false }
            });
        </script>
    </#if>
</div></div>
</#macro>

<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.6.0/Chart.min.js" type="text/javascript"></script>

<div class="row"><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Order Count", '#,##0', (ordersThis.orderCount)!0.0, (ordersLast.orderCount)!0.0, (ordersPrior.orderCount)!0.0,
    (ordersAverage.orderCount)!0.0, ec.resource.expression("orderSummaryNoTotals*.orderCount", "")/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "New Customer Count", '#,##0', (ordersThis.newCustomerOrderCount)!0.0, (ordersLast.newCustomerOrderCount)!0.0, (ordersPrior.newCustomerOrderCount)!0.0,
    (ordersAverage.newCustomerOrderCount)!0.0, ec.resource.expression("orderSummaryNoTotals*.newCustomerOrderCount", "")/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "New Customer Percent", '0.0%', ((ordersThis.newCustomerPercent)!0.0), ((ordersLast.newCustomerPercent)!0.0),
    ((ordersPrior.newCustomerPercent)!0.0), ((ordersAverage.newCustomerPercent)!0.0), newCustomerPercentList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Quantity Sold", '#,##0', (ordersThis.productQuantityTotal)!0.0, (ordersLast.productQuantityTotal)!0.0,
    (ordersPrior.productQuantityTotal)!0.0, (ordersAverage.productQuantityTotal)!0.0, ec.resource.expression("orderSummaryNoTotals*.productQuantityTotal", "")/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Product Sales", '$#,##0', (ordersThis.productSaleTotal)!0.0, (ordersLast.productSaleTotal)!0.0,
    (ordersPrior.productSaleTotal)!0.0, (ordersAverage.productSaleTotal)!0.0, orderProductSaleTotalList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Discount Percent", '0.0%', ((ordersThis.discountPercent)!0.0), ((ordersLast.discountPercent)!0.0),
    ((ordersPrior.discountPercent)!0.0), ((ordersAverage.discountPercent)!0.0), orderDiscountPercentList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Net Product", '$#,##0', (ordersThis.netSales)!0.0, (ordersLast.netSales)!0.0,
    (ordersPrior.netSales)!0.0, (ordersAverage.netSales)!0.0, orderNetSalesList/>

</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Invoice Count", '#,##0', (invoicesThis.invoiceCount)!0.0, (invoicesLast.invoiceCount)!0.0,
    (invoicesPrior.invoiceCount)!0.0, (invoicesAverage.invoiceCount)!0.0, ec.resource.expression("invoiceSummaryNoTotals*.invoiceCount", "")/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Invoiced Quantity", '#,##0', (invoicesThis.productQuantityTotal)!0.0, (invoicesLast.productQuantityTotal)!0.0,
    (invoicesPrior.productQuantityTotal)!0.0, (invoicesAverage.productQuantityTotal)!0.0, ec.resource.expression("invoiceSummaryNoTotals*.productQuantityTotal", "")/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Invoices Total", '$#,##0', (invoicesThis.invoiceTotal)!0.0, (invoicesLast.invoiceTotal)!0.0,
    (invoicesPrior.invoiceTotal)!0.0, (invoicesAverage.invoiceTotal)!0.0, invoiceTotalList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Paid Percent", '0.0%', ((invoicesThis.paidPercent)!0.0), ((invoicesLast.paidPercent)!0.0),
    ((invoicesPrior.paidPercent)!0.0), ((invoicesAverage.paidPercent)!0.0), invoicePaidPercentList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Invoice Cost Percent", '0.0%', ((invoicesThis.costPercent)!0.0), ((invoicesLast.costPercent)!0.0),
    ((invoicesPrior.costPercent)!0.0), ((invoicesAverage.costPercent)!0.0), invoiceCostPercentList/>
</div><div class="col-lg-3 col-md-4 col-sm-4 col-xs-6">
<@statsPanel "Invoice Discount Percent", '0.0%', ((invoicesThis.discountPercent)!0.0), ((invoicesLast.discountPercent)!0.0),
    ((invoicesPrior.discountPercent)!0.0), ((invoicesAverage.discountPercent)!0.0), invoiceDiscountPercentList/>
</div></div>

<div class="row"><div class="col-md-4 col-sm-6">
    <div class="chart-container" style="position:relative; height:300px; width:100%;"><canvas id="CountSummaryChart"></canvas></div>
</div><div class="col-md-4 col-sm-6">
    <div class="chart-container" style="position:relative; height:300px; width:100%;"><canvas id="OrderAmountChart"></canvas></div>
</div><div class="col-md-4 col-sm-6">
    <div class="chart-container" style="position:relative; height:300px; width:100%;"><canvas id="InvoiceMarginChart"></canvas></div>
</div><div class="col-md-4 col-sm-6">
    <div class="chart-container" style="position:relative; height:300px; width:100%;"><canvas id="DiscountCostChart"></canvas></div>
</div></div>
<script>
    var CountSummaryChart = new Chart(document.getElementById("CountSummaryChart"), { type: 'line',
        data: { labels:${Static["groovy.json.JsonOutput"].toJson(orderLabelList)},
            datasets:${Static["groovy.json.JsonOutput"].toJson(countSummaryDatasets)} },
        options: { scales:{ yAxes: [{ position:'left', id:'leftSide', ticks:{beginAtZero:true} },
            { position:'right', id:'rightSide', ticks:{beginAtZero:true}, gridLines:{drawOnChartArea:false} }] }, maintainAspectRatio:false }
    });
    var OrderAmountChart = new Chart(document.getElementById("OrderAmountChart"), { type: 'line',
        data: { labels:${Static["groovy.json.JsonOutput"].toJson(orderLabelList)},
            datasets:${Static["groovy.json.JsonOutput"].toJson(orderAmountsDatasets)} },
        options: { scales:{ yAxes: [{ position:'left', id:'leftSide', ticks:{beginAtZero:true} },
            { position:'right', id:'rightSide', ticks:{beginAtZero:true}, gridLines:{drawOnChartArea:false} }] }, maintainAspectRatio:false }
    });
    var InvoiceMarginChart = new Chart(document.getElementById("InvoiceMarginChart"), { type: 'bar',
        data: { labels:${Static["groovy.json.JsonOutput"].toJson(invoiceLabelList)},
            datasets:${Static["groovy.json.JsonOutput"].toJson(invoiceMarginDatasets)} },
        options: { scales:{ yAxes: [{ ticks:{beginAtZero:true} }] }, maintainAspectRatio:false }
    });
    var DiscountCostChart = new Chart(document.getElementById("DiscountCostChart"), { type: 'line',
        data: { labels:${Static["groovy.json.JsonOutput"].toJson(invoiceLabelList)},
            datasets:${Static["groovy.json.JsonOutput"].toJson(discountCostDatasets)} },
        options: { scales:{ yAxes: [{ ticks:{beginAtZero:true} }] }, maintainAspectRatio:false }
    });
</script>
