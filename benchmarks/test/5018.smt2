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

(declare-sort var1625 0)
(declare-sort var2245 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2245_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1286 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1286 null-String)))
(define-const var1491 Bool (var2245_isEmpty/-813097145 var1286)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $z1 = 0 
(assert (not (not (= (ite var1491 1 0) 0)))) ; Negate: Cond: $z0 != 0  
(define-const var1841 Bool (ite (= 1 1) true false)) ; Statement: $z1 = 1 
 ; Statement: goto [?= return $z1] 
(assert true) ; Non Conditional
 ; Statement: return $z1 
(check-sat)
; {var2245_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1286=r0, var1625=null_type, var2245=org.apache.dubbo.common.utils.StringUtils, var1491=$z0, var1841=$z1}
; {r0=var1286, null_type=var1625, org.apache.dubbo.common.utils.StringUtils=var2245, $z0=var1491, $z1=var1841}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto $z1 = 0;	$z1 = 1;	goto [?= return $z1];	return $z1
;block_num 3