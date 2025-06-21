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

(declare-sort var443 0)
(declare-sort var3927 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/1929860173 (var443 String String) var443)
(declare-const null-var443 var443)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var1434 var443) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1434 null-var443)))
(declare-const var1025 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1025 null-String)))
(declare-const var3202 Int) ; Statement: s0 := @parameter1: short 
(assert (not (= var3202 null-Int)))
(define-const var2684 Int (cast-from-Int-to-Int var3202)) ; Statement: $i1 = (int) s0 
(define-const var627 String (String_valueOf/1240665136 var2684)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var1682 var443 (addParameter/1929860173 var1434 var1025 var627)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([short], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var443=org.apache.dubbo.common.URLBuilder, var1434=r0, var1025=r1, var3927=null_type, var3202=s0, var2684=$i1, var627=$r2, var1682=$r3}
; {org.apache.dubbo.common.URLBuilder=var443, r0=var1434, r1=var1025, null_type=var3927, s0=var3202, $i1=var2684, $r2=var627, $r3=var1682}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	s0 := @parameter1: short;	$i1 = (int) s0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1