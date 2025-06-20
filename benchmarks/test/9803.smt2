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

(declare-sort var2941 0)
(declare-sort var1460 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun toFullString/-798704221 (var1460) String)
(declare-fun compareTo/1411385946 (String String) Int)
(declare-const null-var2941 var2941)
(declare-const null-var1460 var1460)
(declare-const var2935 var2941) ; Statement: r4 := @this: org.apache.dubbo.metadata.MetadataInfo$URLComparator 
(assert (not (= var2935 null-var2941)))
(declare-const var3113 var1460) ; Statement: r0 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var3113 null-var1460)))
(declare-const var2575 var1460) ; Statement: r1 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var2575 null-var1460)))
(assert true)
(define-const var1136 String (toFullString/-798704221 var3113)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var905 String (toFullString/-798704221 var2575)) ; Statement: $r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String toFullString()>() 
(assert true)
(define-const var3511 Int (compareTo/1411385946 var1136 var905)) ; Statement: $i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2) 
(assert (let ((this<other (str.< var1136 var905)) (this<=other (str.<= var1136 var905)) (compareRes (compareTo/1411385946 var1136 var905))) (or (and (> compareRes 0) (not this<=other)) (and (< compareRes 0) this<other) (and (= compareRes 0) (not this<other) this<=other))))
 ; Statement: return $i0 
(check-sat)
; {toFullString/-798704221=([org.apache.dubbo.common.URL], java.lang.String), compareTo/1411385946=([java.lang.String, java.lang.String], int)}
; {var2941=org.apache.dubbo.metadata.MetadataInfo$URLComparator, var2935=r4, var1460=org.apache.dubbo.common.URL, var3113=r0, var2575=r1, var1136=$r3, var905=$r2, var3511=$i0}
; {org.apache.dubbo.metadata.MetadataInfo$URLComparator=var2941, r4=var2935, org.apache.dubbo.common.URL=var1460, r0=var3113, r1=var2575, $r3=var1136, $r2=var905, $i0=var3511}
;seq <java.lang.String: int compareTo(java.lang.String)>
;cnt {"<java.lang.String: int compareTo(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.metadata.MetadataInfo$URLComparator;	r0 := @parameter0: org.apache.dubbo.common.URL;	r1 := @parameter1: org.apache.dubbo.common.URL;	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$r2 = virtualinvoke r1.<org.apache.dubbo.common.URL: java.lang.String toFullString()>();	$i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2);	return $i0
;block_num 1