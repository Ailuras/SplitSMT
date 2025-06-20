(set-option :produce-unsat-cores true) ; enable generation of unsat cores
(set-option :produce-models true) ; enable model generation
(set-logic ALL)

; 统一获取长度的函数
(define-fun get_split_length ((x String) (d String) (limit Int)) Int
  (ite
    (> limit 0)
    (ite (< (str.num_splits x d) limit)
         (str.num_splits x d)
         limit)
    (str.num_splits x d)
  )
)

; 统一获取元素的函数
(define-fun get_split_element ((x String) (d String) (limit Int) (i Int)) String
  (ite
    (and (> limit 0)
         (= i (- limit 1))
         (>= (str.num_splits x d) limit))
    (str.split_rest x d (- limit 1))
    (str.split_at x d i)
  )
)

(declare-sort var3642 0)
(declare-sort var2141 0)
(declare-sort var814 0)
(declare-sort var3724 0)
(declare-sort var179 0)
(declare-sort var1730 0)
(declare-sort var1765 0)
(declare-sort var3567 0)
(declare-sort var921 0)
(declare-sort var3164 0)
(declare-sort var671 0)
(declare-sort var219 0)
(declare-sort var1666 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var179!class ClassObject)
(declare-fun var814-init () var814)
(declare-fun <init>/-325640736 (var814) void)
(declare-fun var3724_getExtensionLoader/-185181833 (ClassObject) var3724)
(declare-fun getSupportedExtensions/1220760995 (var3724) var1730)
(declare-fun var1765-init () var1765)
(declare-fun <init>/-201242697 (var1765) void)
(declare-fun var1730_iterator/1911472585 (var1730) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var921_getSummaryStatus/-2029479363 (var3164) var3567)
(declare-fun cast-from-var1765-to-var3164 (var1765) var3164)
(declare-fun getPath/1543588576 (var2141) String)
(declare-fun var671-init () var671)
(declare-fun getLevel/-1795247963 (var3567) var219)
(declare-fun toString/1761020461 (var1666) String)
(declare-fun cast-from-var219-to-var1666 (var219) var1666)
(declare-fun <init>/-797647045 (var671 String String String String) void)
(declare-const null-var3642 var3642)
(declare-const null-var2141 var2141)
(declare-const var1370 var3642) ; Statement: r8 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler 
(assert (not (= var1370 null-var3642)))
(declare-const var595 var2141) ; Statement: r4 := @parameter0: com.alibaba.dubbo.common.URL 
(assert (not (= var595 null-var2141)))
(define-const var1527 var814 var814-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var1527)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var1527!1 var814)
(define-const var93 var3724 (var3724_getExtensionLoader/-185181833 var179!class)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lcom/alibaba/dubbo/common/status/StatusChecker;") 
(assert true)
(define-const var800 var1730 (getSupportedExtensions/1220760995 var93)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensions()>() 
(define-const var2733 var1765 var1765-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var2733)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>()>() 

(declare-const var2733!1 var1765)
(define-const var1199 Iterator (var1730_iterator/1911472585 var800)) ; Statement: r27 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3001 Bool (Iterator_hasNext/-1669924200 var1199)) ; Statement: $z0 = interfaceinvoke r27.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3) 
(assert (= (ite var3001 1 0) 0)) ; Cond: $z0 == 0 
(define-const var257 var3567 (var921_getSummaryStatus/-2029479363 (cast-from-var1765-to-var3164 var2733!1))) ; Statement: r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3) 
(define-const var2188 String "status") ; Statement: $r6 = "status" 
(assert true)
(define-const var2867 String (getPath/1543588576 var595)) ; Statement: $r5 = virtualinvoke r4.<com.alibaba.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var1435 Bool (= var2188 var2867)) ; Statement: $z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if $z1 == 0 goto $r7 = new java.util.ArrayList 
(assert (not (= (ite var1435 1 0) 0))) ; Negate: Cond: $z1 == 0  
(define-const var2836 var671 var671-init) ; Statement: $r13 = new com.alibaba.dubbo.container.page.Page 
(assert true)
(define-const var410 var219 (getLevel/-1795247963 var257)) ; Statement: $r14 = virtualinvoke r29.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>() 
(assert true)
(define-const var149 String (toString/1761020461 (cast-from-var219-to-var1666 var410))) ; Statement: $r15 = virtualinvoke $r14.<org.apache.dubbo.common.status.Status$Level: java.lang.String toString()>() 
(assert true)
;(assert (<init>/-797647045 var2836 "" "" "" var149)) ; Statement: specialinvoke $r13.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("", "", "", $r15) 

(declare-const var2836!1 var671)
(declare-const var3827 String)
(declare-const var3827!1 String)
(declare-const var3827!2 String)
(declare-const var149!1 String)
 ; Statement: return $r13 
(check-sat)
; {var814-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var3724_getExtensionLoader/-185181833=([java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), getSupportedExtensions/1220760995=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Set), var1765-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var1730_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var921_getSummaryStatus/-2029479363=([java.util.Map], org.apache.dubbo.common.status.Status), cast-from-var1765-to-var3164=([java.util.HashMap], java.util.Map), getPath/1543588576=([com.alibaba.dubbo.common.URL], java.lang.String), var671-init=([], com.alibaba.dubbo.container.page.Page), getLevel/-1795247963=([org.apache.dubbo.common.status.Status], org.apache.dubbo.common.status.Status$Level), toString/1761020461=([java.lang.Enum], java.lang.String), cast-from-var219-to-var1666=([org.apache.dubbo.common.status.Status$Level], java.lang.Enum), <init>/-797647045=([com.alibaba.dubbo.container.page.Page, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void)}
; {var3642=com.alibaba.dubbo.container.page.pages.StatusPageHandler, var1370=r8, var2141=com.alibaba.dubbo.common.URL, var595=r4, var814=java.util.ArrayList, var1527=$r0, var3724=org.apache.dubbo.common.extension.ExtensionLoader, var179=com.alibaba.dubbo.common.status.StatusChecker, var93=$r1, var1730=java.util.Set, var800=r2, var1765=java.util.HashMap, var2733=$r3, var1199=r27, var3001=$z0, var3567=org.apache.dubbo.common.status.Status, var921=org.apache.dubbo.common.status.support.StatusUtils, var3164=java.util.Map, var257=r29, var2188=$r6, var2867=$r5, var1435=$z1, var671=com.alibaba.dubbo.container.page.Page, var2836=$r13, var219=org.apache.dubbo.common.status.Status$Level, var410=$r14, var1666=java.lang.Enum, var149=$r15, var3827=""}
; {com.alibaba.dubbo.container.page.pages.StatusPageHandler=var3642, r8=var1370, com.alibaba.dubbo.common.URL=var2141, r4=var595, java.util.ArrayList=var814, $r0=var1527, org.apache.dubbo.common.extension.ExtensionLoader=var3724, com.alibaba.dubbo.common.status.StatusChecker=var179, $r1=var93, java.util.Set=var1730, r2=var800, java.util.HashMap=var1765, $r3=var2733, r27=var1199, $z0=var3001, org.apache.dubbo.common.status.Status=var3567, org.apache.dubbo.common.status.support.StatusUtils=var921, java.util.Map=var3164, r29=var257, $r6=var2188, $r5=var2867, $z1=var1435, com.alibaba.dubbo.container.page.Page=var671, $r13=var2836, org.apache.dubbo.common.status.Status$Level=var219, $r14=var410, java.lang.Enum=var1666, $r15=var149, ""=var3827}
;seq <java.lang.String: boolean equals(java.lang.Object)>;	<java.lang.Enum: java.lang.String toString()>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r8 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler;	r4 := @parameter0: com.alibaba.dubbo.common.URL;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lcom/alibaba/dubbo/common/status/StatusChecker;");	r2 = virtualinvoke $r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensions()>();	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>()>();	r27 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r27.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3);	r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3);	$r6 = "status";	$r5 = virtualinvoke r4.<com.alibaba.dubbo.common.URL: java.lang.String getPath()>();	$z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if $z1 == 0 goto $r7 = new java.util.ArrayList;	$r13 = new com.alibaba.dubbo.container.page.Page;	$r14 = virtualinvoke r29.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>();	$r15 = virtualinvoke $r14.<org.apache.dubbo.common.status.Status$Level: java.lang.String toString()>();	specialinvoke $r13.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("", "", "", $r15);	return $r13
;block_num 4