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

(declare-sort var3347 0)
(declare-sort var423 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/-1629709269 (var3347 String String) var3347)
(declare-const null-var3347 var3347)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1991 var3347) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var1991 null-var3347)))
(declare-const var2179 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var2179 null-String)))
(declare-const var911 Int) ; Statement: b0 := @parameter1: byte 
(assert (not (= var911 null-Int)))
(define-const var1911 Int (cast-from-Int-to-Int var911)) ; Statement: $i1 = (int) b0 
(define-const var759 String (String_valueOf/1240665136 var1911)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var1594 var3347 (addParameter/-1629709269 var1991 var2179 var759)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([byte], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var3347=org.apache.dubbo.common.URL, var1991=r0, var2179=r1, var423=null_type, var911=b0, var1911=$i1, var759=$r2, var1594=$r3}
; {org.apache.dubbo.common.URL=var3347, r0=var1991, r1=var2179, null_type=var423, b0=var911, $i1=var1911, $r2=var759, $r3=var1594}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	b0 := @parameter1: byte;	$i1 = (int) b0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1