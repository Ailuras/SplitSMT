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

(declare-sort var1064 0)
(declare-sort var185 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-1855000632 (var185) String)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getCategory/80858349 (var185 (Array Int String)) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-var1064 var1064)
(declare-const null-var185 var185)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var746 var1064) ; Statement: r5 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var746 null-var1064)))
(declare-const var1413 var185) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1413 null-var185)))
(define-const var2784 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var2997 String (getCategory/-1855000632 var1413)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>() 
(assert true)
(define-const var2091 Bool (= var2784 var2997)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = newarray (java.lang.String)[1] 
(assert (= (ite var2091 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1111 (Array Int String) arr-String-init) ; Statement: $r3 = newarray (java.lang.String)[1] 
(declare-const var1111!1 (Array Int String))
(assert (not (= var1111!1 null-__Array__Int__String__)))
(assert (= (select var1111!1 0) "providers")) ; Statement: $r3[0] = "providers" 
(assert true)
(define-const var114 (Array Int String) (getCategory/80858349 var1413 var1111!1)) ; Statement: r14 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String[] getCategory(java.lang.String[])>($r3) 
(assert true) ; Non Conditional
(define-const var1526 Int (getLength-Arr-String-1 var114)) ; Statement: $i0 = lengthof r14 
(define-const var1412 (Array Int String) arr-String-init) ; Statement: $r13 = newarray (java.lang.String)[$i0] 
(define-const var1396 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var2033 Int (getLength-Arr-String-1 var114)) ; Statement: $i2 = lengthof r14 
 ; Statement: if i1 >= $i2 goto return $r13 
(assert (>= var1396 var2033)) ; Cond: i1 >= $i2 
 ; Statement: return $r13 
(check-sat)
; {getCategory/-1855000632=([org.apache.dubbo.common.URL], java.lang.String), arr-String-init=([], java.lang.String[]), getCategory/80858349=([org.apache.dubbo.common.URL, java.lang.String[]], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int)}
; {var1064=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var746=r5, var185=org.apache.dubbo.common.URL, var1413=r0, var2784=$r2, var2997=$r1, var2091=$z0, var1111=$r3, var114=r14, var1526=$i0, var1412=$r13, var1396=i1, var2033=$i2}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var1064, r5=var746, org.apache.dubbo.common.URL=var185, r0=var1413, $r2=var2784, $r1=var2997, $z0=var2091, $r3=var1111, r14=var114, $i0=var1526, $r13=var1412, i1=var1396, $i2=var2033}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = newarray (java.lang.String)[1];	$r3 = newarray (java.lang.String)[1];	$r3[0] = "providers";	r14 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String[] getCategory(java.lang.String[])>($r3);	$i0 = lengthof r14;	$r13 = newarray (java.lang.String)[$i0];	i1 = 0;	$i2 = lengthof r14;	if i1 >= $i2 goto return $r13;	return $r13
;block_num 5