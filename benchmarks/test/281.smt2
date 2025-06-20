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

(declare-sort var2174 0)
(declare-sort var3901 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun contains/1009244746 ((s String) (subs String)) Bool (str.contains s subs))
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var2174 var2174)
(declare-const null-String String)
(declare-const var701 var2174) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.pattern.range.RangeValuePattern 
(assert (not (= var701 null-var2174)))
(declare-const var1150 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1150 null-String)))
(assert true)
(define-const var3466 Bool (contains/1009244746 var1150 (cast-from-String-to-String "~"))) ; Statement: $z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("~") 
 ; Statement: return $z0 
(check-sat)
; {contains/1009244746=([java.lang.String, java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2174=org.apache.dubbo.rpc.cluster.router.condition.matcher.pattern.range.RangeValuePattern, var701=r1, var1150=r0, var3901=null_type, var3466=$z0}
; {org.apache.dubbo.rpc.cluster.router.condition.matcher.pattern.range.RangeValuePattern=var2174, r1=var701, r0=var1150, null_type=var3901, $z0=var3466}
;seq <java.lang.String: boolean contains(java.lang.CharSequence)>
;cnt {"<java.lang.String: boolean contains(java.lang.CharSequence)>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.condition.matcher.pattern.range.RangeValuePattern;	r0 := @parameter0: java.lang.String;	$z0 = virtualinvoke r0.<java.lang.String: boolean contains(java.lang.CharSequence)>("~");	return $z0
;block_num 1