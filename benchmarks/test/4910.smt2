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

(declare-sort var1947 0)
(declare-sort var251 0)
(declare-sort var3129 0)
(declare-sort var1286 0)
(declare-sort var1687 0)
(declare-sort var3935 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var1286) void)
(declare-fun cast-from-var1947-to-var1286 (var1947) var1286)
(declare-fun var1687_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getMetaData/-2015772312 (var251) var3935)
(declare-fun metaData/1658161024 (var1947) var3935)
(declare-const null-var1947 var1947)
(declare-const null-var251 var251)
(declare-const null-String String)
(declare-const var2679 var1947) ; Statement: r0 := @this: org.apache.dubbo.config.context.ConfigConfigurationAdapter 
(assert (not (= var2679 null-var1947)))
(declare-const var832 var251) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var832 null-var251)))
(declare-const var2971 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var2971 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var1947-to-var1286 var2679))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var2679!1 var1947)
(define-const var663 Bool (var1687_hasText/853333513 (cast-from-String-to-String var2971))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>() 
(assert (= (ite var663 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var2661 var3935 (getMetaData/-2015772312 var832)) ; Statement: $r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>() 
(declare-const var2679!2 var1947)
(assert (not (= var2679!2 null-var1947)))
(assert (= (metaData/1658161024 var2679!2) var2661)) ; Statement: r0.<org.apache.dubbo.config.context.ConfigConfigurationAdapter: java.util.Map metaData> = $r3 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var1947-to-var1286=([org.apache.dubbo.config.context.ConfigConfigurationAdapter], java.lang.Object), var1687_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getMetaData/-2015772312=([org.apache.dubbo.config.AbstractConfig], java.util.Map), metaData/1658161024=([org.apache.dubbo.config.context.ConfigConfigurationAdapter], java.util.Map)}
; {var1947=org.apache.dubbo.config.context.ConfigConfigurationAdapter, var2679=r0, var251=org.apache.dubbo.config.AbstractConfig, var832=r2, var2971=r1, var3129=null_type, var1286=java.lang.Object, var1687=org.apache.dubbo.common.utils.StringUtils, var663=$z0, var3935=java.util.Map, var2661=$r3}
; {org.apache.dubbo.config.context.ConfigConfigurationAdapter=var1947, r0=var2679, org.apache.dubbo.config.AbstractConfig=var251, r2=var832, r1=var2971, null_type=var3129, java.lang.Object=var1286, org.apache.dubbo.common.utils.StringUtils=var1687, $z0=var663, java.util.Map=var3935, $r3=var2661}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.context.ConfigConfigurationAdapter;	r2 := @parameter0: org.apache.dubbo.config.AbstractConfig;	r1 := @parameter1: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>();	$r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>();	r0.<org.apache.dubbo.config.context.ConfigConfigurationAdapter: java.util.Map metaData> = $r3;	return
;block_num 3