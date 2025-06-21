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

(declare-sort var1835 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_toString/-1426662429 (String) String)
(declare-fun compareTo/1411385946 (String String) Int)
(declare-const null-var1835 var1835)
(declare-const null-String String)
(declare-const var3284 var1835) ; Statement: r4 := @this: org.apache.dubbo.common.utils.CharSequenceComparator 
(assert (not (= var3284 null-var1835)))
(declare-const var3540 String) ; Statement: r0 := @parameter0: java.lang.CharSequence 
(assert (not (= var3540 null-String)))
(declare-const var538 String) ; Statement: r1 := @parameter1: java.lang.CharSequence 
(assert (not (= var538 null-String)))
(define-const var232 String (String_toString/-1426662429 var3540)) ; Statement: $r3 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>() 
(define-const var1554 String (String_toString/-1426662429 var538)) ; Statement: $r2 = interfaceinvoke r1.<java.lang.CharSequence: java.lang.String toString()>() 
(assert true)
(define-const var2889 Int (compareTo/1411385946 var232 var1554)) ; Statement: $i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2) 
(assert (let ((this<other (str.< var232 var1554)) (this<=other (str.<= var232 var1554)) (compareRes (compareTo/1411385946 var232 var1554))) (or (and (> compareRes 0) (not this<=other)) (and (< compareRes 0) this<other) (and (= compareRes 0) (not this<other) this<=other))))
 ; Statement: return $i0 
(check-sat)
; {String_toString/-1426662429=([java.lang.CharSequence], java.lang.String), compareTo/1411385946=([java.lang.String, java.lang.String], int)}
; {var1835=org.apache.dubbo.common.utils.CharSequenceComparator, var3284=r4, var3540=r0, var538=r1, var232=$r3, var1554=$r2, var2889=$i0}
; {org.apache.dubbo.common.utils.CharSequenceComparator=var1835, r4=var3284, r0=var3540, r1=var538, $r3=var232, $r2=var1554, $i0=var2889}
;seq <java.lang.CharSequence: java.lang.String toString()>;	<java.lang.CharSequence: java.lang.String toString()>;	<java.lang.String: int compareTo(java.lang.String)>
;cnt {"<java.lang.CharSequence: java.lang.String toString()>": 2,"<java.lang.String: int compareTo(java.lang.String)>": 1}
;stmts r4 := @this: org.apache.dubbo.common.utils.CharSequenceComparator;	r0 := @parameter0: java.lang.CharSequence;	r1 := @parameter1: java.lang.CharSequence;	$r3 = interfaceinvoke r0.<java.lang.CharSequence: java.lang.String toString()>();	$r2 = interfaceinvoke r1.<java.lang.CharSequence: java.lang.String toString()>();	$i0 = virtualinvoke $r3.<java.lang.String: int compareTo(java.lang.String)>($r2);	return $i0
;block_num 1