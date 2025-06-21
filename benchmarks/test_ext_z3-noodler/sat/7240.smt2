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

(declare-sort var3300 0)
(declare-sort var3540 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3540_isEmpty/-813097145 (String) Bool)
(declare-const null-String String)
(declare-const var1818 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1818 null-String)))
(declare-const var1095 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var1095 null-String)))
(define-const var2598 Bool (var3540_isEmpty/-813097145 var1818)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $r2 = r0 
(assert (not (= (ite var2598 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1179 String var1095) ; Statement: $r2 = r1 
 ; Statement: goto [?= return $r2] 
(assert true) ; Non Conditional
 ; Statement: return $r2 
(check-sat)
; {var3540_isEmpty/-813097145=([java.lang.String], boolean)}
; {var1818=r0, var3300=null_type, var1095=r1, var3540=org.apache.dubbo.common.utils.StringUtils, var2598=$z0, var1179=$r2}
; {r0=var1818, null_type=var3300, r1=var1095, org.apache.dubbo.common.utils.StringUtils=var3540, $z0=var2598, $r2=var1179}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	r1 := @parameter1: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r0);	if $z0 == 0 goto $r2 = r0;	$r2 = r1;	goto [?= return $r2];	return $r2
;block_num 3