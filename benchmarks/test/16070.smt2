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

(declare-sort var2907 0)
(declare-sort var208 0)
(declare-sort var2539 0)
(declare-sort var2535 0)
(declare-sort var963 0)
(declare-sort var1081 0)
(declare-sort var2468 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2539-init () var2539)
(declare-fun <init>/-325640736 (var2539) void)
(declare-fun getNotified/2133625438 (var963) var2535)
(declare-fun cast-from-var2907-to-var963 (var2907) var963)
(declare-fun var2535_get/1088891777 (var2535 var1081) var1081)
(declare-fun cast-from-var208-to-var1081 (var208) var1081)
(declare-fun cast-from-var1081-to-var2535 (var1081) var2535)
(declare-fun var2468_isEmpty/-153543822 (var2468) Bool)
(declare-fun cast-from-var2539-to-var2468 (var2539) var2468)
(declare-fun getServiceInterface/-1311863806 (var208) String)
(declare-const null-var2907 var2907)
(declare-const null-var208 var208)
(declare-const null-var2535 var2535)
(declare-const var3220 var2907) ; Statement: r1 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry 
(assert (not (= var3220 null-var2907)))
(declare-const var2431 var208) ; Statement: r2 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var2431 null-var208)))
(define-const var3214 var2539 var2539-init) ; Statement: $r0 = new java.util.ArrayList 
(assert true)
;(assert (<init>/-325640736 var3214)) ; Statement: specialinvoke $r0.<java.util.ArrayList: void <init>()>() 

(declare-const var3214!1 var2539)
(assert true)
(define-const var3758 var2535 (getNotified/2133625438 (cast-from-var2907-to-var963 var3220))) ; Statement: $r3 = virtualinvoke r1.<org.apache.dubbo.registry.multicast.MulticastRegistry: java.util.Map getNotified()>() 
(define-const var3992 var1081 (var2535_get/1088891777 var3758 (cast-from-var208-to-var1081 var2431))) ; Statement: $r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2) 
(define-const var591 var2535 (cast-from-var1081-to-var2535 var3992)) ; Statement: r5 = (java.util.Map) $r4 
 ; Statement: if r5 == null goto $z7 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
(assert (= var591 null-var2535)) ; Cond: r5 == null 
(define-const var980 Bool (var2468_isEmpty/-153543822 (cast-from-var2539-to-var2468 var3214!1))) ; Statement: $z7 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z7 == 0 goto $z8 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
(assert (= (ite var980 1 0) 0)) ; Cond: $z7 == 0 
(define-const var2162 Bool (var2468_isEmpty/-153543822 (cast-from-var2539-to-var2468 var3214!1))) ; Statement: $z8 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>() 
 ; Statement: if $z8 == 0 goto $r7 = "*" 
(assert (= (ite var2162 1 0) 0)) ; Cond: $z8 == 0 
(define-const var2968 String "*") ; Statement: $r7 = "*" 
(assert true)
(define-const var3500 String (getServiceInterface/-1311863806 var2431)) ; Statement: $r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>() 
(assert true)
(define-const var1946 Bool (= var2968 var3500)) ; Statement: $z0 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6) 
 ; Statement: if $z0 == 0 goto return $r0 
(assert (= (ite var1946 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return $r0 
(check-sat)
; {var2539-init=([], java.util.ArrayList), <init>/-325640736=([java.util.ArrayList], void), getNotified/2133625438=([org.apache.dubbo.registry.support.AbstractRegistry], java.util.Map), cast-from-var2907-to-var963=([org.apache.dubbo.registry.multicast.MulticastRegistry], org.apache.dubbo.registry.support.AbstractRegistry), var2535_get/1088891777=([java.util.Map, java.lang.Object], java.lang.Object), cast-from-var208-to-var1081=([org.apache.dubbo.common.URL], java.lang.Object), cast-from-var1081-to-var2535=([java.lang.Object], java.util.Map), var2468_isEmpty/-153543822=([java.util.List], boolean), cast-from-var2539-to-var2468=([java.util.ArrayList], java.util.List), getServiceInterface/-1311863806=([org.apache.dubbo.common.URL], java.lang.String)}
; {var2907=org.apache.dubbo.registry.multicast.MulticastRegistry, var3220=r1, var208=org.apache.dubbo.common.URL, var2431=r2, var2539=java.util.ArrayList, var3214=$r0, var2535=java.util.Map, var963=org.apache.dubbo.registry.support.AbstractRegistry, var3758=$r3, var1081=java.lang.Object, var3992=$r4, var591=r5, var2468=java.util.List, var980=$z7, var2162=$z8, var2968=$r7, var3500=$r6, var1946=$z0}
; {org.apache.dubbo.registry.multicast.MulticastRegistry=var2907, r1=var3220, org.apache.dubbo.common.URL=var208, r2=var2431, java.util.ArrayList=var2539, $r0=var3214, java.util.Map=var2535, org.apache.dubbo.registry.support.AbstractRegistry=var963, $r3=var3758, java.lang.Object=var1081, $r4=var3992, r5=var591, java.util.List=var2468, $z7=var980, $z8=var2162, $r7=var2968, $r6=var3500, $z0=var1946}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.registry.multicast.MulticastRegistry;	r2 := @parameter0: org.apache.dubbo.common.URL;	$r0 = new java.util.ArrayList;	specialinvoke $r0.<java.util.ArrayList: void <init>()>();	$r3 = virtualinvoke r1.<org.apache.dubbo.registry.multicast.MulticastRegistry: java.util.Map getNotified()>();	$r4 = interfaceinvoke $r3.<java.util.Map: java.lang.Object get(java.lang.Object)>(r2);	r5 = (java.util.Map) $r4;	if r5 == null goto $z7 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	$z7 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	if $z7 == 0 goto $z8 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	$z8 = interfaceinvoke $r0.<java.util.List: boolean isEmpty()>();	if $z8 == 0 goto $r7 = "*";	$r7 = "*";	$r6 = virtualinvoke r2.<org.apache.dubbo.common.URL: java.lang.String getServiceInterface()>();	$z0 = virtualinvoke $r7.<java.lang.String: boolean equals(java.lang.Object)>($r6);	if $z0 == 0 goto return $r0;	return $r0
;block_num 5