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

(declare-sort var3164 0)
(declare-sort var114 0)
(declare-sort var213 0)
(declare-sort var1211 0)
(declare-sort var2847 0)
(declare-sort var3409 0)
(declare-sort var2158 0)
(declare-sort var636 0)
(declare-sort var3133 0)
(declare-sort var2637 0)
(declare-sort var1757 0)
(declare-sort var649 0)
(declare-sort var362 0)
(declare-sort var2443 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-const var2847!class ClassObject)
(declare-fun var213-init () var213)
(declare-fun <init>/-325640736 (var213) void)
(declare-fun var1211_getExtensionLoader/-185181833 (ClassObject) var1211)
(declare-fun getSupportedExtensions/1220760995 (var1211) var3409)
(declare-fun var2158-init () var2158)
(declare-fun <init>/-201242697 (var2158) void)
(declare-fun var3409_iterator/1911472585 (var3409) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-fun var3133_getSummaryStatus/-2029479363 (var2637) var636)
(declare-fun cast-from-var2158-to-var2637 (var2158) var2637)
(declare-fun getPath/1543588576 (var114) String)
(declare-fun var1757_add/328494887 (var1757 var649) Bool)
(declare-fun cast-from-var213-to-var1757 (var213) var1757)
(declare-fun cast-from-String-to-var649 (String) var649)
(declare-fun getLevel/-1795247963 (var636) var362)
(declare-fun getLevelHtml/659388628 (var3164 var362) String)
(declare-fun cast-from-var213-to-var649 (var213) var649)
(declare-fun var2443-init () var2443)
(declare-fun arr-String-init () (Array Int String))
(declare-fun <init>/581118162 (var2443 String String (Array Int String) var1757) void)
(declare-const null-var3164 var3164)
(declare-const null-var114 var114)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var411 var3164) ; Statement: r8 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler 
(assert (not (= var411 null-var3164)))
(declare-const var3665 var114) ; Statement: r4 := @parameter0: com.alibaba.dubbo.common.URL 
(assert (not (= var3665 null-var114)))
(define-const var2041 var213 var213-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var2041)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var2041!1 var213)
(define-const var3603 var1211 (var1211_getExtensionLoader/-185181833 var2847!class)) ; Statement: $r1 = staticinvoke <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lcom/alibaba/dubbo/common/status/StatusChecker;") 
(assert true)
(define-const var338 var3409 (getSupportedExtensions/1220760995 var3603)) ; Statement: r2 = virtualinvoke $r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensions()>() 
(define-const var3970 var2158 var2158-init) ; Statement: $r3 = new java.util.HashMap 
(assert true)
;(assert (<init>/-201242697 var3970)) ; Statement: specialinvoke $r3.<java.util.HashMap: void <init>()>() 

(declare-const var3970!1 var2158)
(define-const var1078 Iterator (var3409_iterator/1911472585 var338)) ; Statement: r27 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2857 Bool (Iterator_hasNext/-1669924200 var1078)) ; Statement: $z0 = interfaceinvoke r27.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3) 
(assert (= (ite var2857 1 0) 0)) ; Cond: $z0 == 0 
(define-const var2570 var636 (var3133_getSummaryStatus/-2029479363 (cast-from-var2158-to-var2637 var3970!1))) ; Statement: r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3) 
(define-const var3443 String "status") ; Statement: $r6 = "status" 
(assert true)
(define-const var1681 String (getPath/1543588576 var3665)) ; Statement: $r5 = virtualinvoke r4.<com.alibaba.dubbo.common.URL: java.lang.String getPath()>() 
(assert true)
(define-const var3571 Bool (= var3443 var1681)) ; Statement: $z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5) 
 ; Statement: if $z1 == 0 goto $r7 = new java.util.ArrayList 
(assert (= (ite var3571 1 0) 0)) ; Cond: $z1 == 0 
(define-const var426 var213 var213-init) ; Statement: $r7 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var426)) ; Statement: specialinvoke $r7.<java.util.ArrayList: void <init>()>() 

(declare-const var426!1 var213)
;(assert (var1757_add/328494887 (cast-from-var213-to-var1757 var426!1) (cast-from-String-to-var649 "summary"))) ; Statement: interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>("summary") 

(declare-const var426!2 var213)
(declare-const var1752 String)
(assert true)
(define-const var1516 var362 (getLevel/-1795247963 var2570)) ; Statement: $r9 = virtualinvoke r29.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>() 
(assert true)
(define-const var247 String (getLevelHtml/659388628 var411 var1516)) ; Statement: $r10 = specialinvoke r8.<com.alibaba.dubbo.container.page.pages.StatusPageHandler: java.lang.String getLevelHtml(org.apache.dubbo.common.status.Status$Level)>($r9) 
;(assert (var1757_add/328494887 (cast-from-var213-to-var1757 var426!2) (cast-from-String-to-var649 var247))) ; Statement: interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>($r10) 

(declare-const var426!3 var213)
(declare-const var247!1 String)
;(assert (var1757_add/328494887 (cast-from-var213-to-var1757 var426!3) (cast-from-String-to-var649 "<a href=\u0022/status\u0022 target=\u0022_blank\u0022>summary</a>"))) ; Statement: interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>("<a href=\"/status\" target=\"_blank\">summary</a>") 

(declare-const var426!4 var213)
(declare-const var80 String)
;(assert (var1757_add/328494887 (cast-from-var213-to-var1757 var2041!1) (cast-from-var213-to-var649 var426!4))) ; Statement: interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r7) 

(declare-const var2041!2 var213)
(declare-const var426!5 var213)
(define-const var2044 var2443 var2443-init) ; Statement: $r11 = new com.alibaba.dubbo.container.page.Page 
(define-const var1658 (Array Int String) arr-String-init) ; Statement: $r12 = newarray (java.lang.String)[3] 
(declare-const var1658!1 (Array Int String))
(assert (not (= var1658!1 null-__Array__Int__String__)))
(assert (= (select var1658!1 0) "Name")) ; Statement: $r12[0] = "Name" 
(declare-const var1658!2 (Array Int String))
(assert (not (= var1658!2 null-__Array__Int__String__)))
(assert (= (select var1658!2 1) "Status")) ; Statement: $r12[1] = "Status" 
(declare-const var1658!3 (Array Int String))
(assert (not (= var1658!3 null-__Array__Int__String__)))
(assert (= (select var1658!3 2) "Description")) ; Statement: $r12[2] = "Description" 
(assert true)
;(assert (<init>/581118162 var2044 "Status (<a href=\u0022/status\u0022 target=\u0022_blank\u0022>summary</a>)" "Status" var1658!3 (cast-from-var213-to-var1757 var2041!2))) ; Statement: specialinvoke $r11.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Status (<a href=\"/status\" target=\"_blank\">summary</a>)", "Status", $r12, $r0) 

(declare-const var2044!1 var2443)
(declare-const var1375 String)
(declare-const var1455 String)
(declare-const var1658!4 (Array Int String))
(declare-const var2041!3 var213)
 ; Statement: return $r11 
(check-sat)
; {var213-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), var1211_getExtensionLoader/-185181833=([java.lang.Class], org.apache.dubbo.common.extension.ExtensionLoader), getSupportedExtensions/1220760995=([org.apache.dubbo.common.extension.ExtensionLoader], java.util.Set), var2158-init=([], java.util.HashMap), <init>/-201242697=([java.util.HashMap], void), var3409_iterator/1911472585=([java.util.Set], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), var3133_getSummaryStatus/-2029479363=([java.util.Map], org.apache.dubbo.common.status.Status), cast-from-var2158-to-var2637=([java.util.HashMap], java.util.Map), getPath/1543588576=([com.alibaba.dubbo.common.URL], java.lang.String), var1757_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var213-to-var1757=([java.util.ArrayList], java.util.List), cast-from-String-to-var649=([java.lang.String], java.lang.Object), getLevel/-1795247963=([org.apache.dubbo.common.status.Status], org.apache.dubbo.common.status.Status$Level), getLevelHtml/659388628=([com.alibaba.dubbo.container.page.pages.StatusPageHandler, org.apache.dubbo.common.status.Status$Level], java.lang.String), cast-from-var213-to-var649=([java.util.ArrayList], java.lang.Object), var2443-init=([], com.alibaba.dubbo.container.page.Page), arr-String-init=([], java.lang.String[]), <init>/581118162=([com.alibaba.dubbo.container.page.Page, java.lang.String, java.lang.String, java.lang.String[], java.util.List], void)}
; {var3164=com.alibaba.dubbo.container.page.pages.StatusPageHandler, var411=r8, var114=com.alibaba.dubbo.common.URL, var3665=r4, var213=java.util.ArrayList, var2041=$r0, var1211=org.apache.dubbo.common.extension.ExtensionLoader, var2847=com.alibaba.dubbo.common.status.StatusChecker, var3603=$r1, var3409=java.util.Set, var338=r2, var2158=java.util.HashMap, var3970=$r3, var1078=r27, var2857=$z0, var636=org.apache.dubbo.common.status.Status, var3133=org.apache.dubbo.common.status.support.StatusUtils, var2637=java.util.Map, var2570=r29, var3443=$r6, var1681=$r5, var3571=$z1, var426=$r7, var1757=java.util.List, var649=java.lang.Object, var1752="summary", var362=org.apache.dubbo.common.status.Status$Level, var1516=$r9, var247=$r10, var80="<a href=\"/status\" target=\"_blank\">summary</a>", var2443=com.alibaba.dubbo.container.page.Page, var2044=$r11, var1658=$r12, var1375="Status (<a href=\"/status\" target=\"_blank\">summary</a>)", var1455="Status"}
; {com.alibaba.dubbo.container.page.pages.StatusPageHandler=var3164, r8=var411, com.alibaba.dubbo.common.URL=var114, r4=var3665, java.util.ArrayList=var213, $r0=var2041, org.apache.dubbo.common.extension.ExtensionLoader=var1211, com.alibaba.dubbo.common.status.StatusChecker=var2847, $r1=var3603, java.util.Set=var3409, r2=var338, java.util.HashMap=var2158, $r3=var3970, r27=var1078, $z0=var2857, org.apache.dubbo.common.status.Status=var636, org.apache.dubbo.common.status.support.StatusUtils=var3133, java.util.Map=var2637, r29=var2570, $r6=var3443, $r5=var1681, $z1=var3571, $r7=var426, java.util.List=var1757, java.lang.Object=var649, "summary"=var1752, org.apache.dubbo.common.status.Status$Level=var362, $r9=var1516, $r10=var247, "<a href=\"/status\" target=\"_blank\">summary</a>"=var80, com.alibaba.dubbo.container.page.Page=var2443, $r11=var2044, $r12=var1658, "Status (<a href=\"/status\" target=\"_blank\">summary</a>)"=var1375, "Status"=var1455}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r8 := @this: com.alibaba.dubbo.container.page.pages.StatusPageHandler;	r4 := @parameter0: com.alibaba.dubbo.common.URL;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r1 = staticinvoke <org.apache.dubbo.common.extension.ExtensionLoader: org.apache.dubbo.common.extension.ExtensionLoader getExtensionLoader(java.lang.Class)>(class "Lcom/alibaba/dubbo/common/status/StatusChecker;");	r2 = virtualinvoke $r1.<org.apache.dubbo.common.extension.ExtensionLoader: java.util.Set getSupportedExtensions()>();	$r3 = new java.util.HashMap;	specialinvoke $r3.<java.util.HashMap: void <init>()>();	r27 = interfaceinvoke r2.<java.util.Set: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r27.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3);	r29 = staticinvoke <org.apache.dubbo.common.status.support.StatusUtils: org.apache.dubbo.common.status.Status getSummaryStatus(java.util.Map)>($r3);	$r6 = "status";	$r5 = virtualinvoke r4.<com.alibaba.dubbo.common.URL: java.lang.String getPath()>();	$z1 = virtualinvoke $r6.<java.lang.String: boolean equals(java.lang.Object)>($r5);	if $z1 == 0 goto $r7 = new java.util.ArrayList;	$r7 = new java.util.ArrayList;	specialinvoke $r7.<java.util.ArrayList: void <init>()>();	interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>("summary");	$r9 = virtualinvoke r29.<org.apache.dubbo.common.status.Status: org.apache.dubbo.common.status.Status$Level getLevel()>();	$r10 = specialinvoke r8.<com.alibaba.dubbo.container.page.pages.StatusPageHandler: java.lang.String getLevelHtml(org.apache.dubbo.common.status.Status$Level)>($r9);	interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>($r10);	interfaceinvoke $r7.<java.util.List: boolean add(java.lang.Object)>("<a href=\"/status\" target=\"_blank\">summary</a>");	interfaceinvoke $r0.<java.util.List: boolean add(java.lang.Object)>($r7);	$r11 = new com.alibaba.dubbo.container.page.Page;	$r12 = newarray (java.lang.String)[3];	$r12[0] = "Name";	$r12[1] = "Status";	$r12[2] = "Description";	specialinvoke $r11.<com.alibaba.dubbo.container.page.Page: void <init>(java.lang.String,java.lang.String,java.lang.String[],java.util.List)>("Status (<a href=\"/status\" target=\"_blank\">summary</a>)", "Status", $r12, $r0);	return $r11
;block_num 4