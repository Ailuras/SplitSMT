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

(declare-sort var3618 0)
(declare-sort var2939 0)
(declare-sort var2689 0)
(declare-sort var2755 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String_valueOf/-333372740 (var2755) String)
(declare-fun cast-from-var2689-to-var2755 (var2689) var2755)
(declare-fun addParameter/-1629709269 (var3618 String String) var3618)
(declare-const null-var3618 var3618)
(declare-const null-String String)
(declare-const null-var2689 var2689)
(declare-const var3438 var3618) ; Statement: r1 := @this: org.apache.dubbo.common.URL 
(assert (not (= var3438 null-var3618)))
(declare-const var3079 String) ; Statement: r2 := @parameter0: java.lang.String 
(assert (not (= var3079 null-String)))
(declare-const var1505 var2689) ; Statement: r0 := @parameter1: java.lang.Number 
(assert (not (= var1505 null-var2689)))
 ; Statement: if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert (not (= var1505 null-var2689))) ; Cond: r0 != null 
(define-const var657 String (String_valueOf/-333372740 (cast-from-var2689-to-var2755 var1505))) ; Statement: $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0) 
(assert true)
(define-const var1141 var3618 (addParameter/-1629709269 var3438 var3079 var657)) ; Statement: $r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3) 
 ; Statement: return $r4 
(check-sat)
; {String_valueOf/-333372740=([java.lang.Object], java.lang.String), cast-from-var2689-to-var2755=([java.lang.Number], java.lang.Object), addParameter/-1629709269=([org.apache.dubbo.common.URL, java.lang.String, java.lang.String], org.apache.dubbo.common.URL)}
; {var3618=org.apache.dubbo.common.URL, var3438=r1, var3079=r2, var2939=null_type, var2689=java.lang.Number, var1505=r0, var2755=java.lang.Object, var657=$r3, var1141=$r4}
; {org.apache.dubbo.common.URL=var3618, r1=var3438, r2=var3079, null_type=var2939, java.lang.Number=var2689, r0=var1505, java.lang.Object=var2755, $r3=var657, $r4=var1141}
;seq <java.lang.String: java.lang.String valueOf(java.lang.Object)>
;cnt {"<java.lang.String: java.lang.String valueOf(java.lang.Object)>": 1}
;stmts r1 := @this: org.apache.dubbo.common.URL;	r2 := @parameter0: java.lang.String;	r0 := @parameter1: java.lang.Number;	if r0 != null goto $r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r3 = staticinvoke <java.lang.String: java.lang.String valueOf(java.lang.Object)>(r0);	$r4 = virtualinvoke r1.<org.apache.dubbo.common.URL: org.apache.dubbo.common.URL addParameter(java.lang.String,java.lang.String)>(r2, $r3);	return $r4
;block_num 2