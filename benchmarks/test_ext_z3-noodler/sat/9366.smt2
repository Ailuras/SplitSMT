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

(declare-sort var3162 0)
(declare-sort var3125 0)
(declare-sort var3484 0)
(declare-sort var1309 0)
(declare-sort var1364 0)
(declare-sort var120 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun getParameter/-1307325648 (var3125 String) String)
(define-fun equalsIgnoreCase/-92311102 ((this String) (another String)) Bool (let ((upper_this (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all this "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z")) (upper_another (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all (str.replace_all another "a" "A") "b" "B") "c" "C") "d" "D") "e" "E") "f" "F") "g" "G") "h" "H") "i" "I") "j" "J") "k" "K") "l" "L") "m" "M") "n" "N") "o" "O") "p" "P") "q" "Q") "r" "R") "s" "S") "t" "T") "u" "U") "v" "V") "w" "W") "x" "X") "y" "Y") "z" "Z"))) (= upper_this upper_another)))
(declare-fun urls/2049477907 (var1364) var3484)
(declare-fun cast-from-var3162-to-var1364 (var3162) var1364)
(declare-fun var3484_add/328494887 (var3484 var120) Bool)
(declare-fun cast-from-var3125-to-var120 (var3125) var120)
(declare-const null-var3162 var3162)
(declare-const null-var3125 var3125)
(declare-const null-var3484 var3484)
(declare-const null-var1309 var1309)
(declare-const var419 var3162) ; Statement: r2 := @this: org.apache.dubbo.config.ServiceConfig 
(assert (not (= var419 null-var3162)))
(declare-const var1522 var3125) ; Statement: r34 := @parameter0: org.apache.dubbo.common.URL 
(assert (not (= var1522 null-var3125)))
(declare-const var3748 var3484) ; Statement: r7 := @parameter1: java.util.List 
(assert (not (= var3748 null-var3484)))
(declare-const var3235 var1309) ; Statement: r8 := @parameter2: org.apache.dubbo.common.constants.RegisterTypeEnum 
(assert (not (= var3235 null-var1309)))
(assert true)
(define-const var141 String (getParameter/-1307325648 var1522 "scope")) ; Statement: r0 = virtualinvoke r34.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope") 
(define-const var3400 String "none") ; Statement: $r1 = "none" 
(assert true)
(define-const var2556 Bool (equalsIgnoreCase/-92311102 var3400 var141)) ; Statement: $z0 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0) 
 ; Statement: if $z0 != 0 goto $r39 = r2.<org.apache.dubbo.config.ServiceConfig: java.util.List urls> 
(assert (not (= (ite var2556 1 0) 0))) ; Cond: $z0 != 0 
(define-const var1132 var3484 (urls/2049477907 (cast-from-var3162-to-var1364 var419))) ; Statement: $r39 = r2.<org.apache.dubbo.config.ServiceConfig: java.util.List urls> 
;(assert (var3484_add/328494887 var1132 (cast-from-var3125-to-var120 var1522))) ; Statement: interfaceinvoke $r39.<java.util.List: boolean add(java.lang.Object)>(r34) 

(declare-const var1132!1 var3484)
(declare-const var1522!1 var3125)
 ; Statement: return 
(check-sat)
; {getParameter/-1307325648=([org.apache.dubbo.common.URL, java.lang.String], java.lang.String), equalsIgnoreCase/-92311102=([java.lang.String, java.lang.String], boolean), urls/2049477907=([org.apache.dubbo.config.AbstractInterfaceConfig], java.util.List), cast-from-var3162-to-var1364=([org.apache.dubbo.config.ServiceConfig], org.apache.dubbo.config.AbstractInterfaceConfig), var3484_add/328494887=([java.util.List, java.lang.Object], boolean), cast-from-var3125-to-var120=([org.apache.dubbo.common.URL], java.lang.Object)}
; {var3162=org.apache.dubbo.config.ServiceConfig, var419=r2, var3125=org.apache.dubbo.common.URL, var1522=r34, var3484=java.util.List, var3748=r7, var1309=org.apache.dubbo.common.constants.RegisterTypeEnum, var3235=r8, var141=r0, var3400=$r1, var2556=$z0, var1364=org.apache.dubbo.config.AbstractInterfaceConfig, var1132=$r39, var120=java.lang.Object}
; {org.apache.dubbo.config.ServiceConfig=var3162, r2=var419, org.apache.dubbo.common.URL=var3125, r34=var1522, java.util.List=var3484, r7=var3748, org.apache.dubbo.common.constants.RegisterTypeEnum=var1309, r8=var3235, r0=var141, $r1=var3400, $z0=var2556, org.apache.dubbo.config.AbstractInterfaceConfig=var1364, $r39=var1132, java.lang.Object=var120}
;seq <java.lang.String: boolean equalsIgnoreCase(java.lang.String)>
;cnt {"<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>": 1}
;stmts r2 := @this: org.apache.dubbo.config.ServiceConfig;	r34 := @parameter0: org.apache.dubbo.common.URL;	r7 := @parameter1: java.util.List;	r8 := @parameter2: org.apache.dubbo.common.constants.RegisterTypeEnum;	r0 = virtualinvoke r34.<org.apache.dubbo.common.URL: java.lang.String getParameter(java.lang.String)>("scope");	$r1 = "none";	$z0 = virtualinvoke $r1.<java.lang.String: boolean equalsIgnoreCase(java.lang.String)>(r0);	if $z0 != 0 goto $r39 = r2.<org.apache.dubbo.config.ServiceConfig: java.util.List urls>;	$r39 = r2.<org.apache.dubbo.config.ServiceConfig: java.util.List urls>;	interfaceinvoke $r39.<java.util.List: boolean add(java.lang.Object)>(r34);	return
;block_num 2