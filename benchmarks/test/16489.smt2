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

(declare-sort var2676 0)
(declare-sort var3621 0)
(declare-sort var3512 0)
(declare-sort var3031 0)
(declare-sort var3975 0)
(declare-sort var328 0)
(declare-sort var3689 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun length/-134980193 ((s String)) Int (str.len s))
(declare-fun var328_bootstrap$/1733827065 (var2676 var3621) var3975)
(declare-fun var3031_computeIfAbsent/2133881068 (var3031 var3689 var3975) var3689)
(declare-fun cast-from-String-to-var3689 (String) var3689)
(declare-fun cast-from-var3689-to-String (var3689) String)
(declare-const null-var2676 var2676)
(declare-const null-var3621 var3621)
(declare-const null-String String)
(declare-const var2676-processedTable var3031)
(declare-const var420 var2676) ; Statement: r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler 
(assert (not (= var420 null-var2676)))
(declare-const var2969 var3621) ; Statement: r2 := @parameter0: org.apache.dubbo.remoting.Channel 
(assert (not (= var2969 null-var3621)))
(declare-const var668 String) ; Statement: r0 := @parameter1: java.lang.String 
(assert (not (= var668 null-String)))
(assert true)
(define-const var3585 Int (length/-134980193 var668)) ; Statement: $i0 = virtualinvoke r0.<java.lang.String: int length()>() 
 ; Statement: if $i0 <= 0 goto $r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable> 
(assert (<= var3585 0)) ; Cond: $i0 <= 0 
(define-const var2345 var3031 var2676-processedTable) ; Statement: $r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable> 
(define-const var830 var3975 (var328_bootstrap$/1733827065 var420 var2969)) ; Statement: $r4 = staticinvoke <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_1__1225: java.util.function.Function bootstrap$(org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler,org.apache.dubbo.remoting.Channel)>(r1, r2) 
(define-const var1754 var3689 (var3031_computeIfAbsent/2133881068 var2345 (cast-from-String-to-var3689 "mainHelp") var830)) ; Statement: $r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>("mainHelp", $r4) 
(define-const var475 String (cast-from-var3689-to-String var1754)) ; Statement: $r6 = (java.lang.String) $r5 
 ; Statement: return $r6 
(check-sat)
; {length/-134980193=([java.lang.String], int), var328_bootstrap$/1733827065=([org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, org.apache.dubbo.remoting.Channel], java.util.function.Function), var3031_computeIfAbsent/2133881068=([java.util.Map, java.lang.Object, java.util.function.Function], java.lang.Object), cast-from-String-to-var3689=([java.lang.String], java.lang.Object), cast-from-var3689-to-String=([java.lang.Object], java.lang.String)}
; {var2676=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler, var420=r1, var3621=org.apache.dubbo.remoting.Channel, var2969=r2, var668=r0, var3512=null_type, var3585=$i0, var3031=java.util.Map, var2345=$r3, var3975=java.util.function.Function, var328=org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_1__1225, var830=$r4, var3689=java.lang.Object, var1754=$r5, var475=$r6}
; {org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler=var2676, r1=var420, org.apache.dubbo.remoting.Channel=var3621, r2=var2969, r0=var668, null_type=var3512, $i0=var3585, java.util.Map=var3031, $r3=var2345, java.util.function.Function=var3975, org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_1__1225=var328, $r4=var830, java.lang.Object=var3689, $r5=var1754, $r6=var475}
;seq <java.lang.String: int length()>
;cnt {"<java.lang.String: int length()>": 1}
;stmts r1 := @this: org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler;	r2 := @parameter0: org.apache.dubbo.remoting.Channel;	r0 := @parameter1: java.lang.String;	$i0 = virtualinvoke r0.<java.lang.String: int length()>();	if $i0 <= 0 goto $r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable>;	$r3 = <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler: java.util.Map processedTable>;	$r4 = staticinvoke <org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler$lambda_telnet_1__1225: java.util.function.Function bootstrap$(org.apache.dubbo.remoting.telnet.support.command.HelpTelnetHandler,org.apache.dubbo.remoting.Channel)>(r1, r2);	$r5 = interfaceinvoke $r3.<java.util.Map: java.lang.Object computeIfAbsent(java.lang.Object,java.util.function.Function)>("mainHelp", $r4);	$r6 = (java.lang.String) $r5;	return $r6
;block_num 2