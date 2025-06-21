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

(declare-sort var2091 0)
(declare-sort var3003 0)
(declare-sort var667 0)
(declare-sort var1308 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getInterface/326199548 (var3003) String)
(declare-fun cast-from-var2091-to-var3003 (var2091) var3003)
(declare-fun var667_isBlank/-523695098 (String) Bool)
(define-fun cast-from-String-to-String ((arg String)) String arg)
(declare-fun getGroup/1158610875 (var2091) String)
(declare-fun getVersion/-871451774 (var2091) String)
(declare-fun var1308_buildServiceKey/1384461061 (String String String) String)
(declare-const null-var2091 var2091)
(declare-const var1055 var2091) ; Statement: r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase 
(assert (not (= var1055 null-var2091)))
(assert true)
(define-const var2755 String (getInterface/326199548 (cast-from-var2091-to-var3003 var1055))) ; Statement: r10 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getInterface()>() 
(define-const var153 Bool (var667_isBlank/-523695098 (cast-from-String-to-String var2755))) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
 ; Statement: if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
(assert (= (ite var153 1 0) 0)) ; Cond: $z0 == 0 
(define-const var1980 Bool (var667_isBlank/-523695098 (cast-from-String-to-String var2755))) ; Statement: $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10) 
 ; Statement: if $z1 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>() 
(assert (= (ite var1980 1 0) 0)) ; Cond: $z1 == 0 
(assert true)
(define-const var3059 String (getGroup/1158610875 var1055)) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>() 
(assert true)
(define-const var2514 String (getVersion/-871451774 var1055)) ; Statement: $r1 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getVersion()>() 
(define-const var544 String (var1308_buildServiceKey/1384461061 var2755 var3059 var2514)) ; Statement: $r3 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String buildServiceKey(java.lang.String,java.lang.String,java.lang.String)>(r10, $r2, $r1) 
 ; Statement: return $r3 
(check-sat)
; {getInterface/326199548=([org.apache.dubbo.config.AbstractInterfaceConfig], java.lang.String), cast-from-var2091-to-var3003=([org.apache.dubbo.config.ReferenceConfigBase], org.apache.dubbo.config.AbstractInterfaceConfig), var667_isBlank/-523695098=([java.lang.CharSequence], boolean), cast-from-String-to-String=([java.lang.String], java.lang.CharSequence), getGroup/1158610875=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), getVersion/-871451774=([org.apache.dubbo.config.ReferenceConfigBase], java.lang.String), var1308_buildServiceKey/1384461061=([java.lang.String, java.lang.String, java.lang.String], java.lang.String)}
; {var2091=org.apache.dubbo.config.ReferenceConfigBase, var1055=r0, var3003=org.apache.dubbo.config.AbstractInterfaceConfig, var2755=r10, var667=org.apache.dubbo.common.utils.StringUtils, var153=$z0, var1980=$z1, var3059=$r2, var2514=$r1, var1308=org.apache.dubbo.common.BaseServiceMetadata, var544=$r3}
; {org.apache.dubbo.config.ReferenceConfigBase=var2091, r0=var1055, org.apache.dubbo.config.AbstractInterfaceConfig=var3003, r10=var2755, org.apache.dubbo.common.utils.StringUtils=var667, $z0=var153, $z1=var1980, $r2=var3059, $r1=var2514, org.apache.dubbo.common.BaseServiceMetadata=var1308, $r3=var544}
;seq <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>;	<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>
;cnt {"<org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>": 2}
;stmts r0 := @parameter0: org.apache.dubbo.config.ReferenceConfigBase;	r10 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getInterface()>();	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	if $z0 == 0 goto $z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	$z1 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isBlank(java.lang.CharSequence)>(r10);	if $z1 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>();	$r2 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getGroup()>();	$r1 = virtualinvoke r0.<org.apache.dubbo.config.ReferenceConfigBase: java.lang.String getVersion()>();	$r3 = staticinvoke <org.apache.dubbo.common.BaseServiceMetadata: java.lang.String buildServiceKey(java.lang.String,java.lang.String,java.lang.String)>(r10, $r2, $r1);	return $r3
;block_num 3