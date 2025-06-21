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

(declare-sort var3350 0)
(declare-sort var1866 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var1866_isNumber/1050655655 (String) Bool)
(declare-fun Int_parseInt/1370970945 (String) Int)
(declare-const null-String String)
(declare-const var3836 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3836 null-String)))
(define-const var484 Bool (var1866_isNumber/1050655655 var3836)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0) 
 ; Statement: if $z0 == 0 goto $i0 = 0 
(assert (not (= (ite var484 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var857 Int (Int_parseInt/1370970945 var3836)) ; Statement: $i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0) 
 ; Statement: goto [?= return $i0] 
(assert true) ; Non Conditional
 ; Statement: return $i0 
(check-sat)
; {var1866_isNumber/1050655655=([java.lang.String], boolean), Int_parseInt/1370970945=([java.lang.String], int)}
; {var3836=r0, var3350=null_type, var1866=org.apache.dubbo.common.utils.StringUtils, var484=$z0, var857=$i0}
; {r0=var3836, null_type=var3350, org.apache.dubbo.common.utils.StringUtils=var1866, $z0=var484, $i0=var857}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isNumber(java.lang.String)>(r0);	if $z0 == 0 goto $i0 = 0;	$i0 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r0);	goto [?= return $i0];	return $i0
;block_num 3