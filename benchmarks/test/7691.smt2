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

(declare-sort var1896 0)
(declare-sort var497 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-107395227 (Int) String)
(declare-fun addParameter/-1629709269 (var1896 String String) var1896)
(declare-const null-var1896 var1896)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2063 var1896) ; Statement: r0 := @this: org.apache.dubbo.common.URL 
(assert (not (= var2063 null-var1896)))
(declare-const var1439 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1439 null-String)))
(declare-const var2730 Int) ; Statement: l0 := @parameter1: long 
(assert (not (= var2730 null-Int)))
(define-const var3944 String (String_valueOf/-107395227 var2730)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0) 
(assert true)
(define-const var1820 var1896 (addParameter/-1629709269 var2063 var1439 var3944)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {String_valueOf/-107395227=([long], java.lang.String), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var1896=org.apache.dubbo.common.URL, var2063=r0, var1439=r1, var497=null_type, var2730=l0, var3944=$r2, var1820=$r3}
; {org.apache.dubbo.common.URL=var1896, r0=var2063, r1=var1439, null_type=var497, l0=var2730, $r2=var3944, $r3=var1820}
;seq <java.lang.String: java.lang.String valueOf(long)>
;cnt {"<java.lang.String: java.lang.String valueOf(long)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URL;	r1 := @parameter0: java.lang.String;	l0 := @parameter1: long;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(long)>(l0);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1