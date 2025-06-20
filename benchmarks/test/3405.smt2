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

(declare-sort var67 0)
(declare-sort var2731 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2731_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-String String)
(declare-const var2938 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var2938 null-String)))
(define-const var1174 Bool (var2731_isBlank/-523695098 (cast-from-String-to-String var2938))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PATH_CACHE> 
(assert (not (= (ite var1174 1 0) 0))) ; Negate: Cond: $z0 == 0  
 ; Statement: return r0 
(check-sat)
; {var2731_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var2938=r0, var67=null_type, var2731=org.apache.dubbo.common.utils.StringUtils, var1174=$z0}
; {r0=var2938, null_type=var67, org.apache.dubbo.common.utils.StringUtils=var2731, $z0=var1174}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = <org.apache.dubbo.common.url.component.URLItemCache: java.util.Map PATH_CACHE>;	return r0
;block_num 2