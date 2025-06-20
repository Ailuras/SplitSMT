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

(declare-sort var693 0)
(declare-sort var371 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getRevision/1697979119 (var371) String)
(declare-const null-String String)
(declare-const null-var371 var371)
(declare-const var2075 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2075 null-String)))
(declare-const var3995 var371) ; Statement: r1 := @parameter1: org.apache.dubbo.metadata.MetadataInfo 
(assert (not (= var3995 null-var371)))
(assert true)
(define-const var3273 String (getRevision/1697979119 var3995)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getRevision()>() 
(assert true)
(define-const var1739 Bool (= var2075 var3273)) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2) 
 ; Statement: return $z0 
(check-sat)
; {getRevision/1697979119=([org.apache.dubbo.metadata.MetadataInfo], java.lang.String)}
; {var2075=r0, var693=null_type, var371=org.apache.dubbo.metadata.MetadataInfo, var3995=r1, var3273=$r2, var1739=$z0}
; {r0=var2075, null_type=var693, org.apache.dubbo.metadata.MetadataInfo=var371, r1=var3995, $r2=var3273, $z0=var1739}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: org.apache.dubbo.metadata.MetadataInfo;	$r2 = virtualinvoke r1.<org.apache.dubbo.metadata.MetadataInfo: java.lang.String getRevision()>();	$z0 = virtualinvoke r0.<java.lang.String: boolean equals(java.lang.Object)>($r2);	return $z0
;block_num 1