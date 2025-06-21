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

(declare-sort var3006 0)
(declare-sort var2415 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-371898945 (Int) String)
(declare-fun addParameter/1929860173 (var3006 String String) var3006)
(declare-const null-var3006 var3006)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var263 var3006) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var263 null-var3006)))
(declare-const var3044 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var3044 null-String)))
(declare-const var107 Int) ; Statement: c0 := @parameter1: char 
(assert (not (= var107 null-Int)))
(define-const var158 String (String_valueOf/-371898945 var107)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0) 
(assert true)
(define-const var2066 var3006 (addParameter/1929860173 var263 var3044 var158)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-371898945=([char], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var3006=org.apache.dubbo.common.URLBuilder, var263=r0, var3044=r1, var2415=null_type, var107=c0, var158=$r2, var2066=$r3}
; {org.apache.dubbo.common.URLBuilder=var3006, r0=var263, r1=var3044, null_type=var2415, c0=var107, $r2=var158, $r3=var2066}
;seq <java.lang.String: java.lang.String valueOf(char)>
;cnt {"<java.lang.String: java.lang.String valueOf(char)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	c0 := @parameter1: char;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(char)>(c0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1