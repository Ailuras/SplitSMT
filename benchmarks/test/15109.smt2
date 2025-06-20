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

(declare-sort var1931 0)
(declare-sort var2360 0)
(declare-sort var3036 0)
(declare-sort var798 0)
(declare-sort var415 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var2360 String) String)
(declare-fun getParameter/506106603 (var2360 String String) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var415_splitToList/858263979 (String Int) var798)
(declare-fun origReferenceRegistryURLs/-1952966720 (var1931) var798)
(declare-fun filterReferenceRegistry/-422024637 (var1931 var798) var798)
(declare-fun effectReferenceRegistryURLs/-1952966720 (var1931) var798)
(declare-fun var798_iterator/-912451715 (var798) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var1931 var1931)
(declare-const null-var2360 var2360)
(declare-const null-var3036 var3036)
(declare-const var1341 var1931) ; Statement: r3 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry 
(assert (not (= var1341 null-var1931)))
(declare-const var2030 var2360) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2030 null-var2360)))
(declare-const var2998 var3036) ; Statement: r11 := @parameter1: java.util.Map 
(assert (not (= var2998 null-var3036)))
(assert true)
(define-const var2795 String (getParameter/-1307325648 var2030 "reference-registry")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reference-registry") 
(assert true)
(define-const var663 String (getParameter/506106603 var2030 "separator" ",")) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("separator", ",") 
(assert (and true (and (> (str.len var663) 0) (<= 0 0))))
(define-const var3700 Int (charAt/698050440 var663 0)) ; Statement: c0 = virtualinvoke $r2.<java.lang.String: char charAt(int)>(0) 
(define-const var593 var798 (var415_splitToList/858263979 var2795 var3700)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r1, c0) 
(declare-const var1341!1 var1931)
(assert (not (= var1341!1 null-var1931)))
(assert (= (origReferenceRegistryURLs/-1952966720 var1341!1) var593)) ; Statement: r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origReferenceRegistryURLs> = $r4 
(define-const var3297 var798 (origReferenceRegistryURLs/-1952966720 var1341!1)) ; Statement: $r5 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origReferenceRegistryURLs> 
(assert true)
(define-const var2177 var798 (filterReferenceRegistry/-422024637 var1341!1 var3297)) ; Statement: $r6 = virtualinvoke r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List filterReferenceRegistry(java.util.List)>($r5) 
(declare-const var1341!2 var1931)
(assert (not (= var1341!2 null-var1931)))
(assert (= (effectReferenceRegistryURLs/-1952966720 var1341!2) var2177)) ; Statement: r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectReferenceRegistryURLs> = $r6 
(define-const var3789 var798 (effectReferenceRegistryURLs/-1952966720 var1341!2)) ; Statement: $r7 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectReferenceRegistryURLs> 
(define-const var1905 Iterator (var798_iterator/-912451715 var3789)) ; Statement: r8 = interfaceinvoke $r7.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var3069 Bool (Iterator_hasNext/-1669924200 var1905)) ; Statement: $z0 = interfaceinvoke r8.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var3069 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), charAt/698050440=([java.lang.String, int], char), var415_splitToList/858263979=([java.lang.String, char], java.util.List), origReferenceRegistryURLs/-1952966720=([org.apache.dubbo.registry.multiple.MultipleRegistry], java.util.List), filterReferenceRegistry/-422024637=([org.apache.dubbo.registry.multiple.MultipleRegistry, java.util.List], java.util.List), effectReferenceRegistryURLs/-1952966720=([org.apache.dubbo.registry.multiple.MultipleRegistry], java.util.List), var798_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var1931=org.apache.dubbo.registry.multiple.MultipleRegistry, var1341=r3, var2360=org.apache.dubbo.common.URL, var2030=r0, var3036=java.util.Map, var2998=r11, var2795=r1, var663=$r2, var3700=c0, var798=java.util.List, var415=org.apache.dubbo.common.utils.StringUtils, var593=$r4, var3297=$r5, var2177=$r6, var3789=$r7, var1905=r8, var3069=$z0}
; {org.apache.dubbo.registry.multiple.MultipleRegistry=var1931, r3=var1341, org.apache.dubbo.common.URL=var2360, r0=var2030, java.util.Map=var3036, r11=var2998, r1=var2795, $r2=var663, c0=var3700, java.util.List=var798, org.apache.dubbo.common.utils.StringUtils=var415, $r4=var593, $r5=var3297, $r6=var2177, $r7=var3789, r8=var1905, $z0=var3069}
;seq <java.lang.String: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r11 := @parameter1: java.util.Map;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("reference-registry");	$r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("separator", ",");	c0 = virtualinvoke $r2.<java.lang.String: char charAt(int)>(0);	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r1, c0);	r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origReferenceRegistryURLs> = $r4;	$r5 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origReferenceRegistryURLs>;	$r6 = virtualinvoke r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List filterReferenceRegistry(java.util.List)>($r5);	r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectReferenceRegistryURLs> = $r6;	$r7 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectReferenceRegistryURLs>;	r8 = interfaceinvoke $r7.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r8.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	return
;block_num 3