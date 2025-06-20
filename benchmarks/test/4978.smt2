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

(declare-sort var1547 0)
(declare-sort var1982 0)
(declare-sort var1142 0)
(declare-sort var3906 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun checkDefault/-1757698556 (var1982) void)
(declare-fun cast-from-var1547-to-var1982 (var1547) var1982)
(declare-fun name/1190736640 (var1547) String)
(declare-fun preferSerialization/1190736640 (var1547) String)
(declare-fun var3906_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-const null-var1547 var1547)
(declare-const null-String String)
(declare-const var465 var1547) ; Statement: r0 := @this: org.apache.dubbo.config.ProtocolConfig 
(assert (not (= var465 null-var1547)))
(assert true)
;(assert (checkDefault/-1757698556 (cast-from-var1547-to-var1982 var465))) ; Statement: specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void checkDefault()>() 

(declare-const var465!1 var1547)
(define-const var2884 String (name/1190736640 var465!1)) ; Statement: $r1 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String name> 
 ; Statement: if $r1 != null goto $r2 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String preferSerialization> 
(assert (not (= var2884 null-String))) ; Cond: $r1 != null 
(define-const var3079 String (preferSerialization/1190736640 var465!1)) ; Statement: $r2 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String preferSerialization> 
(define-const var364 Bool (var3906_isBlank/-523695098 (cast-from-String-to-String var3079))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r2) 
 ; Statement: if $z0 == 0 goto return 
(assert (= (ite var364 1 0) 0)) ; Cond: $z0 == 0 
 ; Statement: return 
(check-sat)
; {checkDefault/-1757698556=([org.apache.dubbo.config.AbstractConfig], void), cast-from-var1547-to-var1982=([org.apache.dubbo.config.ProtocolConfig], org.apache.dubbo.config.AbstractConfig), name/1190736640=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), preferSerialization/1190736640=([org.apache.dubbo.config.ProtocolConfig], java.lang.String), var3906_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence)}
; {var1547=org.apache.dubbo.config.ProtocolConfig, var465=r0, var1982=org.apache.dubbo.config.AbstractConfig, var2884=$r1, var1142=null_type, var3079=$r2, var3906=org.apache.dubbo.common.utils.StringUtils, var364=$z0}
; {org.apache.dubbo.config.ProtocolConfig=var1547, r0=var465, org.apache.dubbo.config.AbstractConfig=var1982, $r1=var2884, null_type=var1142, $r2=var3079, org.apache.dubbo.common.utils.StringUtils=var3906, $z0=var364}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.ProtocolConfig;	specialinvoke r0.<org.apache.dubbo.config.AbstractConfig: void checkDefault()>();	$r1 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String name>;	if $r1 != null goto $r2 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String preferSerialization>;	$r2 = r0.<org.apache.dubbo.config.ProtocolConfig: java.lang.String preferSerialization>;	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>($r2);	if $z0 == 0 goto return;	return
;block_num 3