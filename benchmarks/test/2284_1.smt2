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

(declare-sort var828 0)
(declare-sort var3983 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun String_valueOf/1240665136 (Int) String)
(declare-fun addParameter/1929860173 (var828 String String) var828)
(declare-const null-var828 var828)
(declare-const null-String String)
(declare-const null-Int Int)
(declare-const var2962 var828) ; Statement: r0 := @this: org.apache.dubbo.common.URLBuilder 
(assert (not (= var2962 null-var828)))
(declare-const var1128 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var1128 null-String)))
(declare-const var304 Int) ; Statement: b0 := @parameter1: byte 
(assert (not (= var304 null-Int)))
(define-const var2171 Int (cast-from-Int-to-Int var304)) ; Statement: $i1 = (int) b0 
(define-const var3237 String (String_valueOf/1240665136 var2171)) ; Statement: $r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1) 
(assert true)
(define-const var3056 var828 (addParameter/1929860173 var2962 var1128 var3237)) ; Statement: $r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2) 
 ; Statement: return $r3 
(check-sat)
; {cast-from-Int-to-Int=([byte], int), String_valueOf/1240665136=([int], java.lang.String), addParameter/1929860173=([org.apache.dubbo.common.URLBuilder, java.lang.String, java.lang.String], org.apache.dubbo.common.URLBuilder)}
; {var828=org.apache.dubbo.common.URLBuilder, var2962=r0, var1128=r1, var3983=null_type, var304=b0, var2171=$i1, var3237=$r2, var3056=$r3}
; {org.apache.dubbo.common.URLBuilder=var828, r0=var2962, r1=var1128, null_type=var3983, b0=var304, $i1=var2171, $r2=var3237, $r3=var3056}
;seq <java.lang.String: java.lang.String valueOf(int)>
;cnt {"<java.lang.String: java.lang.String valueOf(int)>": 1}
;stmts r0 := @this: org.apache.dubbo.common.URLBuilder;	r1 := @parameter0: java.lang.String;	b0 := @parameter1: byte;	$i1 = (int) b0;	$r2 = staticinvoke <java.lang.String: java.lang.String valueOf(int)>($i1);	$r3 = virtualinvoke r0.<org.apache.dubbo.common.URLBuilder: org.apache.dubbo.common.URLBuilder addParameter(java.lang.String,java.lang.String)>(r1, $r2);	return $r3
;block_num 1