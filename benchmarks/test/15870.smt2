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

(declare-sort var3042 0)
(declare-sort var1924 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getCategory/-1855000632 (var1924) String)
(declare-fun arr-String-init () (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-const null-var3042 var3042)
(declare-const null-var1924 var1924)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const var2702 var3042) ; Statement: r5 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry 
(assert (not (= var2702 null-var3042)))
(declare-const var1207 var1924) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1207 null-var1924)))
(define-const var2513 String "*") ; Statement: $r2 = "*" 
(assert true)
(define-const var1774 String (getCategory/-1855000632 var1207)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>() 
(assert true)
(define-const var3065 Bool (= var2513 var1774)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1) 
 ; Statement: if $z0 == 0 goto $r3 = newarray (java.lang.String)[1] 
(assert (not (= (ite var3065 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1254 (Array Int String) arr-String-init) ; Statement: $r12 = newarray (java.lang.String)[4] 
(declare-const var1254!1 (Array Int String))
(assert (not (= var1254!1 null-__Array__Int__String__)))
(assert (= (select var1254!1 0) "providers")) ; Statement: $r12[0] = "providers" 
(declare-const var1254!2 (Array Int String))
(assert (not (= var1254!2 null-__Array__Int__String__)))
(assert (= (select var1254!2 1) "consumers")) ; Statement: $r12[1] = "consumers" 
(declare-const var1254!3 (Array Int String))
(assert (not (= var1254!3 null-__Array__Int__String__)))
(assert (= (select var1254!3 2) "routers")) ; Statement: $r12[2] = "routers" 
(declare-const var1254!4 (Array Int String))
(assert (not (= var1254!4 null-__Array__Int__String__)))
(assert (= (select var1254!4 3) "configurators")) ; Statement: $r12[3] = "configurators" 
(define-const var2771 (Array Int String) var1254!4) ; Statement: r14 = $r12 
 ; Statement: goto [?= $i0 = lengthof r14] 
(assert true) ; Non Conditional
(define-const var3444 Int (getLength-Arr-String-1 var2771)) ; Statement: $i0 = lengthof r14 
(define-const var3451 (Array Int String) arr-String-init) ; Statement: $r13 = newarray (java.lang.String)[$i0] 
(define-const var2419 Int 0) ; Statement: i1 = 0 
(assert true) ; Non Conditional
(define-const var599 Int (getLength-Arr-String-1 var2771)) ; Statement: $i2 = lengthof r14 
 ; Statement: if i1 >= $i2 goto return $r13 
(assert (>= var2419 var599)) ; Cond: i1 >= $i2 
 ; Statement: return $r13 
(check-sat)
; {getCategory/-1855000632=([org.apache.dubbo.common.URL], java.lang.String), arr-String-init=([], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int)}
; {var3042=org.apache.dubbo.registry.zookeeper.ZookeeperRegistry, var2702=r5, var1924=org.apache.dubbo.common.URL, var1207=r0, var2513=$r2, var1774=$r1, var3065=$z0, var1254=$r12, var2771=r14, var3444=$i0, var3451=$r13, var2419=i1, var599=$i2}
; {org.apache.dubbo.registry.zookeeper.ZookeeperRegistry=var3042, r5=var2702, org.apache.dubbo.common.URL=var1924, r0=var1207, $r2=var2513, $r1=var1774, $z0=var3065, $r12=var1254, r14=var2771, $i0=var3444, $r13=var3451, i1=var2419, $i2=var599}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.zookeeper.ZookeeperRegistry;	r0 := @parameter0: org.apache.dubbo.common.URL;	$r2 = "*";	$r1 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String getCategory()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equals(java.lang.Object)>($r1);	if $z0 == 0 goto $r3 = newarray (java.lang.String)[1];	$r12 = newarray (java.lang.String)[4];	$r12[0] = "providers";	$r12[1] = "consumers";	$r12[2] = "routers";	$r12[3] = "configurators";	r14 = $r12;	goto [?= $i0 = lengthof r14];	$i0 = lengthof r14;	$r13 = newarray (java.lang.String)[$i0];	i1 = 0;	$i2 = lengthof r14;	if i1 >= $i2 goto return $r13;	return $r13
;block_num 5