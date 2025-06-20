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

(declare-sort var3823 0)
(declare-sort var1800 0)
(declare-sort var3620 0)
(declare-sort var2087 0)
(declare-sort var3479 0)
(declare-sort var1298 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun <init>/-279557996 (var2087) void)
(declare-fun cast-from-var3823-to-var2087 (var3823) var2087)
(declare-fun var3479_hasText/853333513 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getMetaData/-146592627 (var1800 String) var1298)
(declare-fun metaData/1658161024 (var3823) var1298)
(declare-const null-var3823 var3823)
(declare-const null-var1800 var1800)
(declare-const null-String String)
(declare-const var3728 var3823) ; Statement: r0 := @this: org.apache.dubbo.config.context.ConfigConfigurationAdapter 
(assert (not (= var3728 null-var3823)))
(declare-const var3280 var1800) ; Statement: r2 := @parameter0: org.apache.dubbo.config.AbstractConfig 
(assert (not (= var3280 null-var1800)))
(declare-const var967 String) ; Statement: r1 := @parameter1: java.lang.String 
(assert (not (= var967 null-String)))
(assert true)
;(assert (<init>/-279557996 (cast-from-var3823-to-var2087 var3728))) ; Statement: specialinvoke r0.<java.lang.Object: void <init>()>() 

(declare-const var3728!1 var3823)
(define-const var2964 Bool (var3479_hasText/853333513 (cast-from-String-to-String var967))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r1) 
 ; Statement: if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>() 
(assert (not (= (ite var2964 1 0) 0))) ; Negate: Cond: $z0 == 0  
(assert true)
(define-const var2164 var1298 (getMetaData/-146592627 var3280 var967)) ; Statement: $r4 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData(java.lang.String)>(r1) 
(declare-const var3728!2 var3823)
(assert (not (= var3728!2 null-var3823)))
(assert (= (metaData/1658161024 var3728!2) var2164)) ; Statement: r0.<org.apache.dubbo.config.context.ConfigConfigurationAdapter: java.util.Map metaData> = $r4 
 ; Statement: goto [?= return] 
(assert true) ; Non Conditional
 ; Statement: return 
(check-sat)
; {<init>/-279557996=([java.lang.Object], void), cast-from-var3823-to-var2087=([org.apache.dubbo.config.context.ConfigConfigurationAdapter], java.lang.Object), var3479_hasText/853333513=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getMetaData/-146592627=([org.apache.dubbo.config.AbstractConfig, java.lang.String], java.util.Map), metaData/1658161024=([org.apache.dubbo.config.context.ConfigConfigurationAdapter], java.util.Map)}
; {var3823=org.apache.dubbo.config.context.ConfigConfigurationAdapter, var3728=r0, var1800=org.apache.dubbo.config.AbstractConfig, var3280=r2, var967=r1, var3620=null_type, var2087=java.lang.Object, var3479=org.apache.dubbo.common.utils.StringUtils, var2964=$z0, var1298=java.util.Map, var2164=$r4}
; {org.apache.dubbo.config.context.ConfigConfigurationAdapter=var3823, r0=var3728, org.apache.dubbo.config.AbstractConfig=var1800, r2=var3280, r1=var967, null_type=var3620, java.lang.Object=var2087, org.apache.dubbo.common.utils.StringUtils=var3479, $z0=var2964, java.util.Map=var1298, $r4=var2164}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>": 1}
;stmts r0 := @this: org.apache.dubbo.config.context.ConfigConfigurationAdapter;	r2 := @parameter0: org.apache.dubbo.config.AbstractConfig;	r1 := @parameter1: java.lang.String;	specialinvoke r0.<java.lang.Object: void <init>()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean hasText(java.lang.CharSequence)>(r1);	if $z0 == 0 goto $r3 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData()>();	$r4 = virtualinvoke r2.<org.apache.dubbo.config.AbstractConfig: java.util.Map getMetaData(java.lang.String)>(r1);	r0.<org.apache.dubbo.config.context.ConfigConfigurationAdapter: java.util.Map metaData> = $r4;	goto [?= return];	return
;block_num 3