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

(declare-sort var2227 0)
(declare-sort var3795 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-1629709269 (var2227 String String) var2227)
(declare-const null-var2227 var2227)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2588 var2227) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2588 null-var2227)))
(declare-const var1977 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1977 null-String)))
(declare-const var2784 Int) ; Statement: s0 := @parameter1: short 
(assert (not (= var2784 null-Int)))
(define-const var2541 Int (cast-from-Int-to-Int var2784)) ; Statement: $i1 = (int) s0 
(define-const var1531 String (String_valueOf/1240665136 var2541)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var1572 var2227 (addParameter/-1629709269 var2588 var1977 var1531)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([short], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var2227=org.apache.dubbo.common.URL, var2588=r0, var1977=r1, var3795=null_type, var2784=s0, var2541=$i1, var1531=$r2, var1572=$r3}
; {org.apache.dubbo.common.URL=var2227, r0=var2588, r1=var1977, null_type=var3795, s0=var2784, $i1=var2541, $r2=var1531, $r3=var1572}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	s0 := @parameter1: short;	$i1 = (int) s0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1