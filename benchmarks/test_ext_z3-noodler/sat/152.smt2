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

(declare-sort var2588 0)
(declare-sort var1818 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun argumentIndex/-1241248824 (var2588) (Array Int Int))
(declare-fun getLength-Arr-Int-1 ((Array Int Int)) Int)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var2588 var2588)
(declare-const null-__Array__Int__var1818__ (Array Int var1818))
(declare-const var729 var2588) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector 
(assert (not (= var729 null-var2588)))
(declare-const var3729 (Array Int var1818)) ; Statement: r4 := @parameter0: java.lang.Object[] 
(assert (not (= var3729 null-__Array__Int__var1818__)))
(define-const var3266 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3266)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3266!1 String)
(assert (= var3266!1 ""))
(define-const var2088 (Array Int Int) (argumentIndex/-1241248824 var729)) ; Statement: r2 = r1.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: int[] argumentIndex> 
(define-const var3045 Int (getLength-Arr-Int-1 var2088)) ; Statement: i0 = lengthof r2 
(define-const var3947 Int 0) ; Statement: i3 = 0 
(assert true) ; Non Conditional
 ; Statement: if i3 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
(assert (>= var3947 var3045)) ; Cond: i3 >= i0 
(assert true)
(define-const var988 String (toString/-2075883882 var3266!1)) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r3 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), argumentIndex/-1241248824=([org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector], int[]), getLength-Arr-Int-1=([int[]], int), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var2588=org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector, var729=r1, var1818=java.lang.Object, var3729=r4, var3266=$r0, var2088=r2, var3045=i0, var3947=i3, var988=$r3}
; {org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector=var2588, r1=var729, java.lang.Object=var1818, r4=var3729, $r0=var3266, r2=var2088, i0=var3045, i3=var3947, $r3=var988}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector;	r4 := @parameter0: java.lang.Object[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	r2 = r1.<org.apache.dubbo.rpc.cluster.loadbalance.ConsistentHashLoadBalance$ConsistentHashSelector: int[] argumentIndex>;	i0 = lengthof r2;	i3 = 0;	if i3 >= i0 goto $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r3
;block_num 3