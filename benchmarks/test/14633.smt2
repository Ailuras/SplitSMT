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

(declare-sort var1997 0)
(declare-sort var144 0)
(declare-sort var2528 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getAllUnmodifiableServiceURLs/-1850633576 (var1997) var2528)
(declare-const null-var1997 var1997)
(declare-const null-String String)
(declare-const var763 var1997) ; Statement: r5 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation 
(assert (not (= var763 null-var1997)))
(declare-const var728 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var728 null-String)))
(declare-const var1962 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var1962 null-String)))
(declare-const var3974 String) ; Statement: r3 := @parameter2: java.lang.String 
(assert (not (= var3974 null-String)))
(declare-const var3823 String) ; Statement: r6 := @parameter3: java.lang.String 
(assert (not (= var3823 null-String)))
(define-const var2407 String "*") ; Statement: $r1 = "*" 
(assert true)
(define-const var1466 Bool (= var2407 var728)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0) 
 ; Statement: if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3) 
(assert (not (= (ite var1466 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var511 var2528 (getAllUnmodifiableServiceURLs/-1850633576 var763)) ; Statement: $r10 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.SortedSet getAllUnmodifiableServiceURLs()>() 
 ; Statement: return $r10 
(check-sat)
; {getAllUnmodifiableServiceURLs/-1850633576=([org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation], java.util.SortedSet)}
; {var1997=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation, var763=r5, var728=r0, var144=null_type, var1962=r2, var3974=r3, var3823=r6, var2407=$r1, var1466=$z0, var2528=java.util.SortedSet, var511=$r10}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation=var1997, r5=var763, r0=var728, null_type=var144, r2=var1962, r3=var3974, r6=var3823, $r1=var2407, $z0=var1466, java.util.SortedSet=var2528, $r10=var511}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r5 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation;	r0 := @parameter0: java.lang.String;	r2 := @parameter1: java.lang.String;	r3 := @parameter2: java.lang.String;	r6 := @parameter3: java.lang.String;	$r1 = "*";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r0);	if $z0 == 0 goto r4 = staticinvoke <org.apache.dubbo.common.URL: java.lang.String buildKey(java.lang.String,java.lang.String,java.lang.String)>(r0, r2, r3);	$r10 = specialinvoke r5.<org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation: java.util.SortedSet getAllUnmodifiableServiceURLs()>();	return $r10
;block_num 2