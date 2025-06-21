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

(declare-sort var1893 0)
(declare-sort var2670 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun var2670_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun intern/-1326102057 (String) String)
(declare-const null-String String)
(declare-const var1376 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var1376 null-String)))
(define-const var1055 Bool (var2670_isBlank/-523695098 (cast-from-String-to-String var1376))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0) 
 ; Statement: if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String intern()>() 
(assert (= (ite var1055 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3846 String (intern/-1326102057 var1376)) ; Statement: $r1 = virtualinvoke r0.<java.lang.String: java.lang.String intern()>() 
 ; Statement: return $r1 
(check-sat)
; {var2670_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), intern/-1326102057=([java.lang.String], java.lang.String)}
; {var1376=r0, var1893=null_type, var2670=org.apache.dubbo.common.utils.StringUtils, var1055=$z0, var3846=$r1}
; {r0=var1376, null_type=var1893, org.apache.dubbo.common.utils.StringUtils=var2670, $z0=var1055, $r1=var3846}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<java.lang.String: java.lang.String intern()>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1,"<java.lang.String: java.lang.String intern()>": 1}
;stmts r0 := @parameter0: java.lang.String;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r0);	if $z0 == 0 goto $r1 = virtualinvoke r0.<java.lang.String: java.lang.String intern()>();	$r1 = virtualinvoke r0.<java.lang.String: java.lang.String intern()>();	return $r1
;block_num 2