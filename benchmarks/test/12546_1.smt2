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

(declare-sort var3786 0)
(declare-sort var2694 0)
(declare-sort var1413 0)
(declare-sort var3730 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getServiceKey/-892672314 (var3730) String)
(declare-fun cast-from-var1413-to-var3730 (var1413) var3730)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-const null-var3786 var3786)
(declare-const null-String String)
(declare-const null-var1413 var1413)
(declare-const var2944 var3786) ; Statement: r7 := @this: org.apache.dubbo.qos.command.impl.InvokeTelnet 
(assert (not (= var2944 null-var3786)))
(declare-const var820 String) ; Statement: r1 := @parameter0: java.lang.String 
(assert (not (= var820 null-String)))
(declare-const var3706 var1413) ; Statement: r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel 
(assert (not (= var3706 null-var1413)))
(assert true)
(define-const var292 String (getServiceKey/-892672314 (cast-from-var1413-to-var3730 var3706))) ; Statement: $r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: java.lang.String getServiceKey()>() 
(assert true)
(define-const var2093 Bool (equalsIgnoreCase/-92311102 var292 var820)) ; Statement: $z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r1) 
 ; Statement: if $z0 != 0 goto $z4 = 1 
(assert (not (= (ite var2093 1 0) 0))) ; Cond: $z0 != 0 
(define-const var2712 Bool (ite (= 1 1) true false)) ; Statement: $z4 = 1 
 ; Statement: goto [?= return $z4] 
(assert true) ; Non Conditional
 ; Statement: return $z4 
(check-sat)
; {getServiceKey/-892672314=([org.apache.dubbo.rpc.model.ServiceModel], java.lang.String), cast-from-var1413-to-var3730=([org.apache.dubbo.rpc.model.ProviderModel], org.apache.dubbo.rpc.model.ServiceModel), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean)}
; {var3786=org.apache.dubbo.qos.command.impl.InvokeTelnet, var2944=r7, var820=r1, var2694=null_type, var1413=org.apache.dubbo.rpc.model.ProviderModel, var3706=r0, var3730=org.apache.dubbo.rpc.model.ServiceModel, var292=$r2, var2093=$z0, var2712=$z4}
; {org.apache.dubbo.qos.command.impl.InvokeTelnet=var3786, r7=var2944, r1=var820, null_type=var2694, org.apache.dubbo.rpc.model.ProviderModel=var1413, r0=var3706, org.apache.dubbo.rpc.model.ServiceModel=var3730, $r2=var292, $z0=var2093, $z4=var2712}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r7 := @this: org.apache.dubbo.qos.command.impl.InvokeTelnet;	r1 := @parameter0: java.lang.String;	r0 := @parameter1: org.apache.dubbo.rpc.model.ProviderModel;	$r2 = virtualinvoke r0.<org.apache.dubbo.rpc.model.ProviderModel: java.lang.String getServiceKey()>();	$z0 = virtualinvoke $r2.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r1);	if $z0 != 0 goto $z4 = 1;	$z4 = 1;	goto [?= return $z4];	return $z4
;block_num 3