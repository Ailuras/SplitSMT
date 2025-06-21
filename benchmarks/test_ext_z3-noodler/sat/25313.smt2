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

(declare-sort var2302 0)
(declare-sort var1427 0)
(declare-sort var909 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun attempt/1236144978 (var2302) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun getBaseUrl/-1900615306 (var2302) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var909_warn/126438324 (var909 String String String String var1427) void)
(declare-fun negotiateEnd/1910791024 (var2302) void)
(declare-const null-var2302 var2302)
(declare-const null-var1427 var1427)
(declare-const var2302-LOGGER var909)
(declare-const var1471 var2302) ; Statement: r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient 
(assert (not (= var1471 null-var2302)))
(declare-const var695 var1427) ; Statement: r6 := @parameter0: java.lang.Throwable 
(assert (not (= var695 null-var1427)))
(define-const var2872 Int (attempt/1236144978 var1471)) ; Statement: $i0 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: int attempt> 
(define-const var2878 Int (+ var2872 1)) ; Statement: $i1 = $i0 + 1 
(declare-const var1471!1 var2302)
(assert (not (= var1471!1 null-var2302)))
(assert (= (attempt/1236144978 var1471!1) var2878)) ; Statement: r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: int attempt> = $i1 
 ; Statement: if $i0 >= 8 goto $r2 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(assert (>= var2872 8)) ; Cond: $i0 >= 8 
(define-const var1733 var909 var2302-LOGGER) ; Statement: $r2 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER> 
(define-const var2144 String String-init) ; Statement: $r1 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2144)) ; Statement: specialinvoke $r1.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2144!1 String)
(assert (= var2144!1 ""))
(assert true)
(define-const var361 String (append/672562846 var2144!1 "Max retries 8 reached, HTTP/3 negotiation failed for ")) ; Statement: $r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Max retries 8 reached, HTTP/3 negotiation failed for ") 
(declare-const var2144!2 String)
(assert (= var2144!2 (str.++ var2144!1 "Max retries 8 reached, HTTP/3 negotiation failed for ")))
(assert true)
(define-const var1987 String (getBaseUrl/-1900615306 var1471!1)) ; Statement: $r3 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.lang.String getBaseUrl()>() 
(assert true)
(define-const var1345 String (append/672562846 var361 var1987)) ; Statement: $r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3) 
(declare-const var361!1 String)
(assert (= var361!1 (str.++ var361 var1987)))
(assert true)
(define-const var738 String (toString/-2075883882 var1345)) ; Statement: $r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var909_warn/126438324 var1733 "4-7" "" "" var738 var695)) ; Statement: interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-7", "", "", $r7, r6) 

(declare-const var1733!1 var909)
(declare-const var970 String)
(declare-const var1114 String)
(declare-const var1114!1 String)
(declare-const var738!1 String)
(declare-const var695!1 var1427)
(assert true)
;(assert (negotiateEnd/1910791024 var1471!1)) ; Statement: specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: void negotiateEnd()>() 

(declare-const var1471!2 var2302)
 ; Statement: return 
(check-sat)
; {attempt/1236144978=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), getBaseUrl/-1900615306=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], java.lang.String), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var909_warn/126438324=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String, java.lang.Throwable], void), negotiateEnd/1910791024=([org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient], void)}
; {var2302=org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient, var1471=r0, var1427=java.lang.Throwable, var695=r6, var2872=$i0, var2878=$i1, var909=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var1733=$r2, var2144=$r1, var361=$r4, var1987=$r3, var1345=$r5, var738=$r7, var970="4-7", var1114=""}
; {org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient=var2302, r0=var1471, java.lang.Throwable=var1427, r6=var695, $i0=var2872, $i1=var2878, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var909, $r2=var1733, $r1=var2144, $r4=var361, $r3=var1987, $r5=var1345, $r7=var738, "4-7"=var970, ""=var1114}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r0 := @this: org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient;	r6 := @parameter0: java.lang.Throwable;	$i0 = r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: int attempt>;	$i1 = $i0 + 1;	r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: int attempt> = $i1;	if $i0 >= 8 goto $r2 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r2 = <org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: org.apache.dubbo.common.logger.ErrorTypeAwareLogger LOGGER>;	$r1 = new java.lang.StringBuilder;	specialinvoke $r1.<java.lang.StringBuilder: void <init>()>();	$r4 = virtualinvoke $r1.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Max retries 8 reached, HTTP/3 negotiation failed for ");	$r3 = specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: java.lang.String getBaseUrl()>();	$r5 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>($r3);	$r7 = virtualinvoke $r5.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r2.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String,java.lang.Throwable)>("4-7", "", "", $r7, r6);	specialinvoke r0.<org.apache.dubbo.rpc.protocol.tri.h3.negotiation.AutoSwitchConnectionClient: void negotiateEnd()>();	return
;block_num 2