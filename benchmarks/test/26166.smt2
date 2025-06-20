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

(declare-sort var2339 0)
(declare-sort var2117 0)
(declare-sort var3585 0)
(declare-sort var61 0)
(declare-sort var3086 0)
(declare-sort var854 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getString/-1320900985 (var3585 String) String)
(declare-fun getEnum/311062887 (var3585 String) var61)
(declare-fun cast-from-var61-to-var3086 (var61) var3086)
(declare-fun var854-init () var854)
(declare-fun getValue/103104470 (var3585) String)
(declare-fun getBoolean/1405437673 (var3585 String) Bool)
(declare-fun <init>/971482419 (var854 String Bool String var3086) void)
(declare-const null-var2339 var2339)
(declare-const null-var2117 var2117)
(declare-const null-var3585 var3585)
(declare-const var2237 var2339) ; Statement: r6 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver 
(assert (not (= var2237 null-var2339)))
(declare-const var558 var2117) ; Statement: r7 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta 
(assert (not (= var558 null-var2117)))
(declare-const var3133 var3585) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta 
(assert (not (= var3133 null-var3585)))
(assert true)
(define-const var3231 String (getString/-1320900985 var3133 "defaultValue")) ; Statement: r8 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getString(java.lang.String)>("defaultValue") 
(define-const var2888 String "\n\t\t\n\t\t\n_DEFAULT_NONE_\n\t\t\t\t\n") ; Statement: $r1 = "\n\t\t\n\t\t\n_DEFAULT_NONE_\n\t\t\t\t\n" 
(assert true)
(define-const var1374 Bool (= var2888 var3231)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r8) 
 ; Statement: if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Enum getEnum(java.lang.String)>("type") 
(assert (= (ite var1374 1 0) 0)) ; Cond: $z0 == 0 
(assert true)
(define-const var3812 var61 (getEnum/311062887 var3133 "type")) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Enum getEnum(java.lang.String)>("type") 
(define-const var3943 var3086 (cast-from-var61-to-var3086 var3812)) ; Statement: $r5 = (org.apache.dubbo.remoting.http12.rest.ParamType) $r2 
(define-const var2411 var854 var854-init) ; Statement: $r3 = new org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta 
(assert true)
(define-const var2642 String (getValue/103104470 var3133)) ; Statement: $r4 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>() 
(assert true)
(define-const var3651 Bool (getBoolean/1405437673 var3133 "required")) ; Statement: $z1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: boolean getBoolean(java.lang.String)>("required") 
(assert true)
;(assert (<init>/971482419 var2411 var2642 var3651 var3231 var3943)) ; Statement: specialinvoke $r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta: void <init>(java.lang.String,boolean,java.lang.String,org.apache.dubbo.remoting.http12.rest.ParamType)>($r4, $z1, r8, $r5) 

(declare-const var2411!1 var854)
(declare-const var2642!1 String)
(declare-const var3651!1 Bool)
(declare-const var3231!1 String)
(declare-const var3943!1 var3086)
 ; Statement: return $r3 
(check-sat)
; {getString/-1320900985=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, java.lang.String], java.lang.String), getEnum/311062887=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, java.lang.String], java.lang.Enum), cast-from-var61-to-var3086=([java.lang.Enum], org.apache.dubbo.remoting.http12.rest.ParamType), var854-init=([], org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta), getValue/103104470=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta], java.lang.String), getBoolean/1405437673=([org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, java.lang.String], boolean), <init>/971482419=([org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta, java.lang.String, boolean, java.lang.String, org.apache.dubbo.remoting.http12.rest.ParamType], void)}
; {var2339=org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver, var2237=r6, var2117=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta, var558=r7, var3585=org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta, var3133=r0, var3231=r8, var2888=$r1, var1374=$z0, var61=java.lang.Enum, var3812=$r2, var3086=org.apache.dubbo.remoting.http12.rest.ParamType, var3943=$r5, var854=org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta, var2411=$r3, var2642=$r4, var3651=$z1}
; {org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver=var2339, r6=var2237, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta=var2117, r7=var558, org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta=var3585, r0=var3133, r8=var3231, $r1=var2888, $z0=var1374, java.lang.Enum=var61, $r2=var3812, org.apache.dubbo.remoting.http12.rest.ParamType=var3086, $r5=var3943, org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta=var854, $r3=var2411, $r4=var2642, $z1=var3651}
;seq <java.lang.String: boolean equals(java.lang.Object)>
;cnt {"<java.lang.String: boolean equals(java.lang.Object)>": 1}
;stmts r6 := @this: org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver;	r7 := @parameter0: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.ParameterMeta;	r0 := @parameter1: org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta;	r8 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getString(java.lang.String)>("defaultValue");	$r1 = "\n\t\t\n\t\t\n_DEFAULT_NONE_\n\t\t\t\t\n";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equals(java.lang.Object)>(r8);	if $z0 == 0 goto $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Enum getEnum(java.lang.String)>("type");	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.Enum getEnum(java.lang.String)>("type");	$r5 = (org.apache.dubbo.remoting.http12.rest.ParamType) $r2;	$r3 = new org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta;	$r4 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: java.lang.String getValue()>();	$z1 = virtualinvoke r0.<org.apache.dubbo.rpc.protocol.tri.rest.mapping.meta.AnnotationMeta: boolean getBoolean(java.lang.String)>("required");	specialinvoke $r3.<org.apache.dubbo.rpc.protocol.tri.rest.support.basic.ParamArgumentResolver$ParamNamedValueMeta: void <init>(java.lang.String,boolean,java.lang.String,org.apache.dubbo.remoting.http12.rest.ParamType)>($r4, $z1, r8, $r5);	return $r3
;block_num 2