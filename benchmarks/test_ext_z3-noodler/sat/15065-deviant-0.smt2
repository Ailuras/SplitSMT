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

(declare-sort var882 0)
(declare-sort var174 0)
(declare-sort var2059 0)
(declare-sort var1223 0)
(declare-sort var1480 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var174 String) String)
(declare-fun getParameter/506106603 (var174 String String) String)
(define-fun charAt/698050440 ((s String) (index Int)) Int (str.to_code (str.at s index)))
(declare-fun var1480_splitToList/858263979 (String Int) var1223)
(declare-fun origServiceRegistryURLs/-1952966720 (var882) var1223)
(declare-fun filterServiceRegistry/1449253401 (var882 var1223) var1223)
(declare-fun effectServiceRegistryURLs/-1952966720 (var882) var1223)
(declare-fun var1223_iterator/-912451715 (var1223) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(declare-const null-var882 var882)
(declare-const null-var174 var174)
(declare-const null-var2059 var2059)
(declare-const var2641 var882) ; Statement: r3 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry 
(assert (not (= var2641 null-var882)))
(declare-const var2788 var174) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2788 null-var174)))
(declare-const var75 var2059) ; Statement: r11 := @parameter1: java.util.Map 
(assert (not (= var75 null-var2059)))
(assert true)
(define-const var2179 String (getParameter/-1307325648 var2788 "service-registry")) ; Statement: r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("service-registry") 
(assert true)
(define-const var473 String (getParameter/506106603 var2788 "separator" ",")) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("separator", ",") 
(assert (not (and true (and (> (str.len var473) 0) (<= 0 0)))))
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), getParameter/506106603=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], java.lang.String), charAt/698050440=([java.lang.String, int], char), var1480_splitToList/858263979=([java.lang.String, char], java.util.List), origServiceRegistryURLs/-1952966720=([org.apache.dubbo.registry.multiple.MultipleRegistry], java.util.List), filterServiceRegistry/1449253401=([org.apache.dubbo.registry.multiple.MultipleRegistry, java.util.List], java.util.List), effectServiceRegistryURLs/-1952966720=([org.apache.dubbo.registry.multiple.MultipleRegistry], java.util.List), var1223_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean)}
; {var882=org.apache.dubbo.registry.multiple.MultipleRegistry, var2641=r3, var174=org.apache.dubbo.common.URL, var2788=r0, var2059=java.util.Map, var75=r11, var2179=r1, var473=$r2, var1375=c0, var1223=java.util.List, var1480=org.apache.dubbo.common.utils.StringUtils, var2654=$r4, var2744=$r5, var1073=$r6, var2814=$r7, var1660=r8, var585=$z0}
; {org.apache.dubbo.registry.multiple.MultipleRegistry=var882, r3=var2641, org.apache.dubbo.common.URL=var174, r0=var2788, java.util.Map=var2059, r11=var75, r1=var2179, $r2=var473, c0=var1375, java.util.List=var1223, org.apache.dubbo.common.utils.StringUtils=var1480, $r4=var2654, $r5=var2744, $r6=var1073, $r7=var2814, r8=var1660, $z0=var585}
;seq <java.lang.String: char charAt(int)>;	<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>
;cnt {"<java.lang.String: char charAt(int)>": 1,"<org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.multiple.MultipleRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	r11 := @parameter1: java.util.Map;	r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("service-registry");	$r2 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String,java.lang.String)>("separator", ",");	c0 = virtualinvoke $r2.<java.lang.String: char charAt(int)>(0);	$r4 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: java.util.List splitToList(java.lang.String,char)>(r1, c0);	r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origServiceRegistryURLs> = $r4;	$r5 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List origServiceRegistryURLs>;	$r6 = virtualinvoke r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List filterServiceRegistry(java.util.List)>($r5);	r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectServiceRegistryURLs> = $r6;	$r7 = r3.<org.apache.dubbo.registry.multiple.MultipleRegistry: java.util.List effectServiceRegistryURLs>;	r8 = interfaceinvoke $r7.<java.util.List: java.util.Iterator iterator()>();	$z0 = interfaceinvoke r8.<java.util.Iterator: boolean hasNext()>();	if $z0 == 0 goto return;	return
;block_num 3