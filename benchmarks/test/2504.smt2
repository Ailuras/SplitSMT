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

(declare-sort var3734 0)
(declare-sort var2309 0)
(declare-sort var980 0)
(declare-sort var1700 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var1700) String)
(declare-fun cast-from-var980-to-var1700 (var980) var1700)
(declare-fun addParameter/1929860173 (var3734 String String) var3734)
(declare-const null-var3734 var3734)
(declare-const null-String String)
(declare-const null-var980 var980)
(declare-const var1203 var3734) ; Statement: r1 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var1203 null-var3734)))
(declare-const var2724 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var2724 null-String)))
(declare-const var924 var980) ; Statement: r0 := @parameter1: java.lang.Enum 
(assert (not (= var924 null-var980)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var924 null-var980))) ; Cond: r0 != null 
(define-const var1654 String (String_valueOf/-333372740 (cast-from-var980-to-var1700 var924))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var177 var3734 (addParameter/1929860173 var1203 var2724 var1654)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var980-to-var1700=([java.lang.Enum], java.lang.Object), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var3734=org.apache.dubbo.common.URLBuilder, var1203=r1, var2724=r2, var2309=null_type, var980=java.lang.Enum, var924=r0, var1700=java.lang.Object, var1654=$r3, var177=$r4}
; {org.apache.dubbo.common.URLBuilder=var3734, r1=var1203, r2=var2724, null_type=var2309, java.lang.Enum=var980, r0=var924, java.lang.Object=var1700, $r3=var1654, $r4=var177}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URLBuilder;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Enum;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2