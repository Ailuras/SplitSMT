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

(declare-sort var2061 0)
(declare-sort var2213 0)
(declare-sort var2490 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2490_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const null-var2213 var2213)
(declare-const var1816 String) ; Statement: r3 := @parameter0: java.lang.String 
(assert (not (= var1816 null-String)))
(define-const var3693 var2213 null-var2213) ; Statement: r4 = null 
(define-const var570 Bool (var2490_isBlank/-523695098 (cast-from-String-to-String var1816))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3) 
 ; Statement: if $z0 != 0 goto return r4 
(assert (not (= (ite var570 1 0) 0))) ; Cond: $z0 != 0 
 ; Statement: return r4 
(check-sat)
; {var2490_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1816=r3, var2061=null_type, var2213=org.apache.dubbo.qos.api.CommandContext, var3693=r4, var2490=org.apache.dubbo.common.utils.StringUtils, var570=$z0}
; {r3=var1816, null_type=var2061, org.apache.dubbo.qos.api.CommandContext=var2213, r4=var3693, org.apache.dubbo.common.utils.StringUtils=var2490, $z0=var570}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r3 := @parameter0: java.lang.String;	r4 = null;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r3);	if $z0 != 0 goto return r4;	return r4
;block_num 2