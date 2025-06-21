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

(declare-sort var1992 0)
(declare-sort var2533 0)
(declare-sort var2280 0)
(declare-sort var3190 0)
(declare-sort var1444 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(declare-fun name_match/-1521653120 (var1992) var2533)
(declare-fun append/-1031950772 (String var2280) String)
(declare-fun cast-from-var2533-to-var2280 (var2533) var2280)
(declare-fun argc/-1521653120 (var1992) Int)
(declare-fun cast-from-Int-to-var2280 (Int) var2280)
(declare-fun args/-1521653120 (var1992) var3190)
(declare-fun cast-from-var3190-to-var2280 (var3190) var2280)
(declare-fun argp/-1521653120 (var1992) var3190)
(declare-fun headers/-1521653120 (var1992) var1444)
(declare-fun cast-from-var1444-to-var2280 (var1444) var2280)
(declare-fun append/-1166366385 (String Int) String)
(define-fun toString/-2075883882 ((s String)) String s)
(declare-const null-var1992 var1992)
(declare-const var1309 var1992) ; Statement: r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch 
(assert (not (= var1309 null-var1992)))
(define-const var3189 String String-init) ; Statement: $r0 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var3189)) ; Statement: specialinvoke $r0.<java.lang.StringBuilder: void <init>()>() 
(declare-const var3189!1 String)
(assert (= var3189!1 ""))
(assert true)
(define-const var1735 String (append/672562846 var3189!1 "DubboMethodMatch{name_match=")) ; Statement: $r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMethodMatch{name_match=") 
(declare-const var3189!2 String)
(assert (= var3189!2 (str.++ var3189!1 "DubboMethodMatch{name_match=")))
(define-const var2655 var2533 (name_match/-1521653120 var1309)) ; Statement: $r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch name_match> 
(assert true)
(define-const var1740 String (append/-1031950772 var1735 (cast-from-var2533-to-var2280 var2655))) ; Statement: $r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2) 
(declare-const var1735!1 String)
(assert (str.prefixof var1735 var1735!1))
(assert true)
(define-const var333 String (append/672562846 var1740 ", argc=")) ; Statement: $r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", argc=") 
(declare-const var1740!1 String)
(assert (= var1740!1 (str.++ var1740 ", argc=")))
(define-const var3432 Int (argc/-1521653120 var1309)) ; Statement: $r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.lang.Integer argc> 
(assert true)
(define-const var1913 String (append/-1031950772 var333 (cast-from-Int-to-var2280 var3432))) ; Statement: $r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5) 
(declare-const var333!1 String)
(assert (str.prefixof var333 var333!1))
(assert true)
(define-const var2829 String (append/672562846 var1913 ", args=")) ; Statement: $r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", args=") 
(declare-const var1913!1 String)
(assert (= var1913!1 (str.++ var1913 ", args=")))
(define-const var1856 var3190 (args/-1521653120 var1309)) ; Statement: $r8 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.List args> 
(assert true)
(define-const var3800 String (append/-1031950772 var2829 (cast-from-var3190-to-var2280 var1856))) ; Statement: $r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8) 
(declare-const var2829!1 String)
(assert (str.prefixof var2829 var2829!1))
(assert true)
(define-const var3522 String (append/672562846 var3800 ", argp=")) ; Statement: $r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", argp=") 
(declare-const var3800!1 String)
(assert (= var3800!1 (str.++ var3800 ", argp=")))
(define-const var1423 var3190 (argp/-1521653120 var1309)) ; Statement: $r11 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.List argp> 
(assert true)
(define-const var3331 String (append/-1031950772 var3522 (cast-from-var3190-to-var2280 var1423))) ; Statement: $r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11) 
(declare-const var3522!1 String)
(assert (str.prefixof var3522 var3522!1))
(assert true)
(define-const var3531 String (append/672562846 var3331 ", headers=")) ; Statement: $r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=") 
(declare-const var3331!1 String)
(assert (= var3331!1 (str.++ var3331 ", headers=")))
(define-const var3642 var1444 (headers/-1521653120 var1309)) ; Statement: $r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.Map headers> 
(assert true)
(define-const var1327 String (append/-1031950772 var3531 (cast-from-var1444-to-var2280 var3642))) ; Statement: $r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14) 
(declare-const var3531!1 String)
(assert (str.prefixof var3531 var3531!1))
(assert true)
(define-const var3171 String (append/-1166366385 var1327 125)) ; Statement: $r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125) 
(declare-const var1327!1 String)
(assert (str.prefixof var1327 var1327!1))
(assert true)
(define-const var3169 String (toString/-2075883882 var3171)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>() 
 ; Statement: return $r18 
(check-sat)
; {String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), name_match/-1521653120=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch), append/-1031950772=([java.lang.StringBuilder, java.lang.Object], java.lang.StringBuilder), cast-from-var2533-to-var2280=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch], java.lang.Object), argc/-1521653120=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], java.lang.Integer), cast-from-Int-to-var2280=([java.lang.Integer], java.lang.Object), args/-1521653120=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], java.util.List), cast-from-var3190-to-var2280=([java.util.List], java.lang.Object), argp/-1521653120=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], java.util.List), headers/-1521653120=([org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch], java.util.Map), cast-from-var1444-to-var2280=([java.util.Map], java.lang.Object), append/-1166366385=([java.lang.StringBuilder, char], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String)}
; {var1992=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch, var1309=r1, var3189=$r0, var1735=$r3, var2533=org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch, var2655=$r2, var2280=java.lang.Object, var1740=$r4, var333=$r6, var3432=$r5, var1913=$r7, var2829=$r9, var3190=java.util.List, var1856=$r8, var3800=$r10, var3522=$r12, var1423=$r11, var3331=$r13, var3531=$r15, var1444=java.util.Map, var3642=$r14, var1327=$r16, var3171=$r17, var3169=$r18}
; {org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch=var1992, r1=var1309, $r0=var3189, $r3=var1735, org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch=var2533, $r2=var2655, java.lang.Object=var2280, $r4=var1740, $r6=var333, $r5=var3432, $r7=var1913, $r9=var2829, java.util.List=var3190, $r8=var1856, $r10=var3800, $r12=var3522, $r11=var1423, $r13=var3331, $r15=var3531, java.util.Map=var1444, $r14=var3642, $r16=var1327, $r17=var3171, $r18=var3169}
;seq <java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(char)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>": 5,"<java.lang.StringBuilder: java.lang.StringBuilder append(char)>": 1,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r1 := @this: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch;	$r0 = new java.lang.StringBuilder;	specialinvoke $r0.<java.lang.StringBuilder: void <init>()>();	$r3 = virtualinvoke $r0.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("DubboMethodMatch{name_match=");	$r2 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.StringMatch name_match>;	$r4 = virtualinvoke $r3.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r2);	$r6 = virtualinvoke $r4.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", argc=");	$r5 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.lang.Integer argc>;	$r7 = virtualinvoke $r6.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r5);	$r9 = virtualinvoke $r7.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", args=");	$r8 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.List args>;	$r10 = virtualinvoke $r9.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r8);	$r12 = virtualinvoke $r10.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", argp=");	$r11 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.List argp>;	$r13 = virtualinvoke $r12.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r11);	$r15 = virtualinvoke $r13.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(", headers=");	$r14 = r1.<org.apache.dubbo.rpc.cluster.router.mesh.rule.virtualservice.match.DubboMethodMatch: java.util.Map headers>;	$r16 = virtualinvoke $r15.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.Object)>($r14);	$r17 = virtualinvoke $r16.<java.lang.StringBuilder: java.lang.StringBuilder append(char)>(125);	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.String toString()>();	return $r18
;block_num 1