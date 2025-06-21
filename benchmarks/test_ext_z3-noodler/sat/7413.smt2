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

(declare-sort var2852 0)
(declare-sort var3276 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var3276_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const var3545 String) ; Statement: r1 := @parameter0: java.lang.StringBuilder 
(assert (not (= var3545 null-String)))
(declare-const var3246 String) ; Statement: r2 := @parameter1: java.lang.String 
(assert (not (= var3246 null-String)))
(declare-const var3815 String) ; Statement: r0 := @parameter2: java.lang.String 
(assert (not (= var3815 null-String)))
(define-const var2701 Bool (var3276_hasText/853333513 (cast-from-String-to-String var3815))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var2701 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {var3276_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var3545=r1, var3246=r2, var2852=null_type, var3815=r0, var3276=org.apache.dubbo.common.utils.StringUtils, var2701=$z0}
; {r1=var3545, r2=var3246, null_type=var2852, r0=var3815, org.apache.dubbo.common.utils.StringUtils=var3276, $z0=var2701}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r1 := @parameter0: java.lang.StringBuilder;	r2 := @parameter1: java.lang.String;	r0 := @parameter2: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r0);	if $z0 == 0 goto return;	return
;block_num 2