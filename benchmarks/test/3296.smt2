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

(declare-sort var3450 0)
(declare-sort var2796 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2796_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1945 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1945 null-String)))
(define-const var3872 Bool (var2796_isEmpty/-813097145 var1945)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $z6 = 1 
(assert (not (= (ite var3872 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2516 Bool (ite (= 1 1) true false)) ; Statement: $z6 = 1 
 ; Statement: goto [?= return $z6] 
(assert true) ; Non Conditional
 ; Statement: return $z6 
(check-sat)
; {var2796_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1945=r0, var3450=null_type, var2796=org.apache.dubbo.common.utils.StringUtils, var3872=$z0, var2516=$z6}
; {r0=var1945, null_type=var3450, org.apache.dubbo.common.utils.StringUtils=var2796, $z0=var3872, $z6=var2516}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 != 0 goto $z6 = 1;	$z6 = 1;	goto [?= return $z6];	return $z6
;block_num 3