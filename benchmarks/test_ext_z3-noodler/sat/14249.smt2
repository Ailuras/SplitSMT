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

(declare-sort var599 0)
(declare-sort var1048 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toFullString/-798704221 (var1048) String)
(declare-fun compareTo/1411385946 (String String) Int)
(declare-const null-var599 var599)
(declare-const null-var1048 var1048)
(declare-const var1177 var599) ; Statement: r4 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation$URLComparator 
(assert (not (= var1177 null-var599)))
(declare-const var3074 var1048) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3074 null-var1048)))
(declare-const var3084 var1048) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var3084 null-var1048)))
(assert true)
(define-const var2712 String (toFullString/-798704221 var3074)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var1607 String (toFullString/-798704221 var3084)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var2870 Int (compareTo/1411385946 var2712 var1607)) ; Statement: $i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2) 
(assert (let ((this<other (str.< var2712 var1607)) (this<=other (str.<= var2712 var1607)) (compareRes (compareTo/1411385946 var2712 var1607))) (or (and (> compareRes 0) (not this<=other)) (and (< compareRes 0) this<other) (and (= compareRes 0) (not this<other) this<=other))))
 ; Statement: return $i0 
(check-sat)
; {toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), compareTo/1411385946=([java.lang.String, java.lang.String], int)}
; {var599=org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation$URLComparator, var1177=r4, var1048=org.apache.dubbo.common.URL, var3074=r0, var3084=r1, var2712=$r3, var1607=$r2, var2870=$i0}
; {org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation$URLComparator=var599, r4=var1177, org.apache.dubbo.common.URL=var1048, r0=var3074, r1=var3084, $r3=var2712, $r2=var1607, $i0=var2870}
;seq <java.lang.String: int compareTo(java.lang.String)>
;cnt {"<java.lang.String: int compareTo(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.registry.client.metadata.MetadataServiceDelegation$URLComparator;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.common.URL;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2);	return $i0
;block_num 1