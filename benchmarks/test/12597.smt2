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

(declare-sort var3596 0)
(declare-sort var3223 0)
(declare-sort var916 0)
(declare-sort var3052 0)
(declare-sort var2527 0)
(declare-sort var392 0)
(declare-sort var1726 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun var3052_isEmpty/-813097145 (String) Bool)
(declare-fun dubboProtocol/-304288273 (var3596) var2527)
(declare-fun getServers/241950116 (var1726) var392)
(declare-fun cast-from-var2527-to-var1726 (var2527) var1726)
(declare-fun var392_iterator/-912451715 (var392) Iterator)
(declare-fun Iterator_hasNext/-1669924200 (Iterator) Bool)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var3596 var3596)
(declare-const null-var3223 var3223)
(declare-const null-__Array__Int__String__ (Array Int String))
(declare-const null-String String)
(declare-const var2916 var3596) ; Statement: r2 := @this: org.apache.dubbo.qos.command.impl.PortTelnet 
(assert (not (= var2916 null-var3596)))
(declare-const var3553 var3223) ; Statement: r33 := @parameter0: org.apache.dubbo.qos.api.CommandContext 
(assert (not (= var3553 null-var3223)))
(declare-const var3437 (Array Int String)) ; Statement: r1 := @parameter1: java.lang.String[] 
(assert (not (= var3437 null-__Array__Int__String__)))
(define-const var3556 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3556)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3556!1 String)
(assert (= var3556!1 ""))
(define-const var2391 String null-String) ; Statement: r34 = null 
(define-const var3328 Bool (ite (= 1 0) true false)) ; Statement: z6 = 0 
(define-const var906 Bool (ite (= 1 0) true false)) ; Statement: z8 = 0 
(define-const var808 Bool (ite (= 1 0) true false)) ; Statement: z7 = 0 
(define-const var3779 Int (getLength-Arr-String-1 var3437)) ; Statement: $i0 = lengthof r1 
 ; Statement: if $i0 <= 0 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34) 
(assert (<= var3779 0)) ; Cond: $i0 <= 0 
(define-const var1746 Bool (var3052_isEmpty/-813097145 var2391)) ; Statement: $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34) 
 ; Statement: if $z0 == 0 goto i7 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r34) 
(assert (not (= (ite var1746 1 0) 0))) ; Negate: Cond: $z0 == 0  
(define-const var1491 var2527 (dubboProtocol/-304288273 var2916)) ; Statement: $r17 = r2.<org.apache.dubbo.qos.command.impl.PortTelnet: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol dubboProtocol> 
(assert true)
(define-const var3023 var392 (getServers/241950116 (cast-from-var2527-to-var1726 var1491))) ; Statement: $r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.List getServers()>() 
(define-const var2389 Iterator (var392_iterator/-912451715 var3023)) ; Statement: r36 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>() 
(assert true) ; Non Conditional
(define-const var2235 Bool (Iterator_hasNext/-1669924200 var2389)) ; Statement: $z3 = interfaceinvoke r36.<java.util.Iterator: boolean hasNext()>() 
 ; Statement: if $z3 == 0 goto (branch) 
(assert (= (ite var2235 1 0) 0)) ; Cond: $z3 == 0 
 ; Statement: goto [?= $r43 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>()] 
(assert true) ; Non Conditional
(assert true)
(define-const var1552 String (toString/-2075883882 var3556!1)) ; Statement: $r43 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r43 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), getLength-Arr-String-1=([java.lang.String[]], int), var3052_isEmpty/-813097145=([java.lang.String], boolean), dubboProtocol/-304288273=([org.apache.dubbo.qos.command.impl.PortTelnet], org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol), getServers/241950116=([org.apache.dubbo.rpc.protocol.AbstractProtocol], java.util.List), cast-from-var2527-to-var1726=([org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol], org.apache.dubbo.rpc.protocol.AbstractProtocol), var392_iterator/-912451715=([java.util.List], java.util.Iterator), Iterator_hasNext/-1669924200=([java.util.Iterator], boolean), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var3596=org.apache.dubbo.qos.command.impl.PortTelnet, var2916=r2, var3223=org.apache.dubbo.qos.api.CommandContext, var3553=r33, var3437=r1, var3556=$r0, var916=null_type, var2391=r34, var3328=z6, var906=z8, var808=z7, var3779=$i0, var3052=org.apache.dubbo.common.utils.StringUtils, var1746=$z0, var2527=org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol, var1491=$r17, var392=java.util.List, var1726=org.apache.dubbo.rpc.protocol.AbstractProtocol, var3023=$r18, var2389=r36, var2235=$z3, var1552=$r43}
; {org.apache.dubbo.qos.command.impl.PortTelnet=var3596, r2=var2916, org.apache.dubbo.qos.api.CommandContext=var3223, r33=var3553, r1=var3437, $r0=var3556, null_type=var916, r34=var2391, z6=var3328, z8=var906, z7=var808, $i0=var3779, org.apache.dubbo.common.utils.StringUtils=var3052, $z0=var1746, org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol=var2527, $r17=var1491, java.util.List=var392, org.apache.dubbo.rpc.protocol.AbstractProtocol=var1726, $r18=var3023, r36=var2389, $z3=var2235, $r43=var1552}
;seq <java.lang.StringBuilder: void <init>()>;	<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r2 := @this: org.apache.dubbo.qos.command.impl.PortTelnet;	r33 := @parameter0: org.apache.dubbo.qos.api.CommandContext;	r1 := @parameter1: java.lang.String[];	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	r34 = null;	z6 = 0;	z8 = 0;	z7 = 0;	$i0 = lengthof r1;	if $i0 <= 0 goto $z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34);	$z0 = staticinvoke <org.apache.dubbo.common.utils.StringUtils: boolean isEmpty(java.lang.String)>(r34);	if $z0 == 0 goto i7 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>(r34);	$r17 = r2.<org.apache.dubbo.qos.command.impl.PortTelnet: org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol dubboProtocol>;	$r18 = virtualinvoke $r17.<org.apache.dubbo.rpc.protocol.dubbo.DubboProtocol: java.util.List getServers()>();	r36 = interfaceinvoke $r18.<java.util.List: java.util.Iterator iterator()>();	$z3 = interfaceinvoke r36.<java.util.Iterator: boolean hasNext()>();	if $z3 == 0 goto (branch);	goto [?= $r43 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>()];	$r43 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.String toString()>();	return $r43
;block_num 6