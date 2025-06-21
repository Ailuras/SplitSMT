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

(declare-sort var882 0)
(declare-sort var1018 0)
(declare-sort var3767 0)
(declare-sort var464 0)
(declare-sort var1870 0)
(declare-sort var1550 0)
(declare-sort var1234 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var1550_bootstrap$/1156163590 (var882) var1870)
(declare-fun var464_computeIfAbsent/2133881068 (var464 var1234 var1870) var1234)
(declare-fun cast-from-String-to-var1234 (String) var1234)
(declare-fun cast-from-var1234-to-String (var1234) String)
(declare-const null-var882 var882)
(declare-const null-var1018 var1018)
(declare-const null-String String)
(declare-const var882-processedTable var464)
(declare-const var1440 var882) ; Statement: r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler 
(assert (not (= var1440 null-var882)))
(declare-const var3640 var1018) ; Statement: r2 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var3640 null-var1018)))
(declare-const var3124 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var3124 null-String)))
(assert true)
(define-const var188 Int (length/-134980193 var3124)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable> 
(assert (not (<= var188 0))) ; Negate: Cond: $i0 <= 0  
(define-const var333 var464 var882-processedTable) ; Statement: $r7 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable> 
(define-const var3173 var1870 (var1550_bootstrap$/1156163590 var1440)) ; Statement: $r8 = staticinvoke <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_0__1227: java.util.function.Function bootstrap$(org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler)>(r1) 
(define-const var723 var1234 (var464_computeIfAbsent/2133881068 var333 (cast-from-String-to-var1234 var3124) var3173)) ; Statement: $r9 = interfaceinvoke $r7.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r0, $r8) 
(define-const var1164 String (cast-from-var1234-to-String var723)) ; Statement: $r10 = (java.lang.String) $r9 
 ; Statement: return $r10 
(check-sat)
; {length/-134980193=([java.lang.String], int), var1550_bootstrap$/1156163590=([org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler], java.util.function.Function), var464_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var1234=([java.lang.String], java.lang.Object), cast-from-var1234-to-String=([java.lang.Object], java.lang.String)}
; {var882=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, var1440=r1, var1018=org.apache.dubbo.remoting.Channel, var3640=r2, var3124=r0, var3767=null_type, var188=$i0, var464=java.util.Map, var333=$r7, var1870=java.util.function.Function, var1550=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_0__1227, var3173=$r8, var1234=java.lang.Object, var723=$r9, var1164=$r10}
; {org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler=var882, r1=var1440, org.apache.dubbo.remoting.Channel=var1018, r2=var3640, r0=var3124, null_type=var3767, $i0=var188, java.util.Map=var464, $r7=var333, java.util.function.Function=var1870, org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_0__1227=var1550, $r8=var3173, java.lang.Object=var1234, $r9=var723, $r10=var1164}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler;	r2 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 <= 0 goto $r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable>;	$r7 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable>;	$r8 = staticinvoke <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_0__1227: java.util.function.Function bootstrap$(org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler)>(r1);	$r9 = interfaceinvoke $r7.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>(r0, $r8);	$r10 = (java.lang.String) $r9;	return $r10
;block_num 2