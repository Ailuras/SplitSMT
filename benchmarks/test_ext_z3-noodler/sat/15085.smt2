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

(declare-sort var105 0)
(declare-sort var196 0)
(declare-sort var2462 0)
(declare-sort var3535 0)
(declare-sort var688 0)
(declare-sort var562 0)
(declare-sort var1386 0)
(declare-sort void 0)
(declare-sort Iterator 0)
(declare-sort ClassObject 0)
(define-fun indexOf/-1209756239 ((s String) (subs String)) Int (str.indexof s subs 0))
(define-fun cast-from-Int-to-Int ((arg Int)) Int arg)
(declare-fun var688_parseRawURLToArrays/2089857807 (String Int) (Array Int String))
(declare-fun getLength-Arr-String-1 ((Array Int String)) Int)
(declare-fun String-init () String)
(define-fun <init>/1968657023 () String "")
(define-fun append/672562846 ((s String) (tail String)) String (str.++ s tail))
(define-fun toString/-2075883882 ((s String)) String s)
(declare-fun var562_warn/1431914100 (var562 String String String String) void)
(declare-fun var1386_valueOf/-1471452032 (String var2462) var1386)
(declare-const null-var105 var105)
(declare-const null-String String)
(declare-const null-var2462 var2462)
(declare-const null-var3535 var3535)
(declare-const var105-logger var562)
(declare-const var1706 var105) ; Statement: r3 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry 
(assert (not (= var1706 null-var105)))
(declare-const var3875 String) ; Statement: r0 := @parameter0: java.lang.String 
(assert (not (= var3875 null-String)))
(declare-const var717 var2462) ; Statement: r13 := @parameter1: org.apache.dubbo.common.URL 
(assert (not (= var717 null-var2462)))
(declare-const var3968 var3535) ; Statement: r8 := @parameter2: java.util.Map 
(assert (not (= var3968 null-var3535)))
(define-const var2733 Bool (ite (= 1 1) true false)) ; Statement: z1 = 1 
(define-const var2715 Bool (ite (= 1 1) true false)) ; Statement: z3 = 1 
(define-const var1719 Bool (ite (= 1 1) true false)) ; Statement: z2 = 1 
(assert true)
(define-const var603 Int (indexOf/-1209756239 var3875 "%3F")) ; Statement: i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("%3F") 
(define-const var404 Int (cast-from-Int-to-Int -1)) ; Statement: $i5 = (int) -1 
 ; Statement: if i0 != $i5 goto $r21 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String[] parseRawURLToArrays(java.lang.String,int)>(r0, i0) 
(assert (not (= var603 var404))) ; Cond: i0 != $i5 
(define-const var1822 (Array Int String) (var688_parseRawURLToArrays/2089857807 var3875 var603)) ; Statement: $r21 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String[] parseRawURLToArrays(java.lang.String,int)>(r0, i0) 
(define-const var1010 Int (getLength-Arr-String-1 var1822)) ; Statement: $i1 = lengthof $r21 
 ; Statement: if $i1 > 1 goto r1 = $r21[0] 
(assert (not (> var1010 1))) ; Negate: Cond: $i1 > 1  
(define-const var2258 var562 var105-logger) ; Statement: $r16 = <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger> 
(define-const var2847 String String-init) ; Statement: $r22 = new java.lang.StringBuilder 
(assert true)
;(assert (<init>/1968657023 var2847)) ; Statement: specialinvoke $r22.<java.lang.StringBuilder: void <init>()>() 
(declare-const var2847!1 String)
(assert (= var2847!1 ""))
(assert true)
(define-const var302 String (append/672562846 var2847!1 "Received url without any parameters ")) ; Statement: $r17 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received url without any parameters ") 
(declare-const var2847!2 String)
(assert (= var2847!2 (str.++ var2847!1 "Received url without any parameters ")))
(assert true)
(define-const var967 String (append/672562846 var302 var3875)) ; Statement: $r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0) 
(declare-const var302!1 String)
(assert (= var302!1 (str.++ var302 var3875)))
(assert true)
(define-const var799 String (toString/-2075883882 var967)) ; Statement: $r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>() 
;(assert (var562_warn/1431914100 var2258 "1-5" "" "" var799)) ; Statement: interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-5", "", "", $r19) 

(declare-const var2258!1 var562)
(declare-const var2020 String)
(declare-const var2075 String)
(declare-const var2075!1 String)
(declare-const var799!1 String)
(define-const var1973 var1386 (var1386_valueOf/-1471452032 var3875 var717)) ; Statement: $r20 = staticinvoke <org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.DubboServiceAddressURL valueOf(java.lang.String,org.apache.dubbo.common.URL)>(r0, r13) 
 ; Statement: return $r20 
(check-sat)
; {indexOf/-1209756239=([java.lang.String, java.lang.String], int), cast-from-Int-to-Int=([int], int), var688_parseRawURLToArrays/2089857807=([java.lang.String, int], java.lang.String[]), getLength-Arr-String-1=([java.lang.String[]], int), String-init=([], java.lang.StringBuilder), <init>/1968657023=([java.lang.StringBuilder], void), append/672562846=([java.lang.StringBuilder, java.lang.String], java.lang.StringBuilder), toString/-2075883882=([java.lang.StringBuilder], java.lang.String), var562_warn/1431914100=([org.apache.dubbo.common.logger.ErrorTypeAwareLogger, java.lang.String, java.lang.String, java.lang.String, java.lang.String], void), var1386_valueOf/-1471452032=([java.lang.String, org.apache.dubbo.common.URL], org.apache.dubbo.common.url.component.DubboServiceAddressURL)}
; {var105=org.apache.dubbo.registry.support.CacheableFailbackRegistry, var1706=r3, var3875=r0, var196=null_type, var2462=org.apache.dubbo.common.URL, var717=r13, var3535=java.util.Map, var3968=r8, var2733=z1, var2715=z3, var1719=z2, var603=i0, var404=$i5, var688=org.apache.dubbo.common.URLStrParser, var1822=$r21, var1010=$i1, var562=org.apache.dubbo.common.logger.ErrorTypeAwareLogger, var2258=$r16, var2847=$r22, var302=$r17, var967=$r18, var799=$r19, var2020="1-5", var2075="", var1386=org.apache.dubbo.common.url.component.DubboServiceAddressURL, var1973=$r20}
; {org.apache.dubbo.registry.support.CacheableFailbackRegistry=var105, r3=var1706, r0=var3875, null_type=var196, org.apache.dubbo.common.URL=var2462, r13=var717, java.util.Map=var3535, r8=var3968, z1=var2733, z3=var2715, z2=var1719, i0=var603, $i5=var404, org.apache.dubbo.common.URLStrParser=var688, $r21=var1822, $i1=var1010, org.apache.dubbo.common.logger.ErrorTypeAwareLogger=var562, $r16=var2258, $r22=var2847, $r17=var302, $r18=var967, $r19=var799, "1-5"=var2020, ""=var2075, org.apache.dubbo.common.url.component.DubboServiceAddressURL=var1386, $r20=var1973}
;seq <java.lang.String: int indexOf(java.lang.String)>;	<java.lang.StringBuilder: void <init>()>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>;	<java.lang.StringBuilder: java.lang.String toString()>
;cnt {"<java.lang.String: int indexOf(java.lang.String)>": 1,"<java.lang.StringBuilder: void <init>()>": 1,"<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>": 2,"<java.lang.StringBuilder: java.lang.String toString()>": 1}
;stmts r3 := @this: org.apache.dubbo.registry.support.CacheableFailbackRegistry;	r0 := @parameter0: java.lang.String;	r13 := @parameter1: org.apache.dubbo.common.URL;	r8 := @parameter2: java.util.Map;	z1 = 1;	z3 = 1;	z2 = 1;	i0 = virtualinvoke r0.<java.lang.String: int indexOf(java.lang.String)>("%3F");	$i5 = (int) -1;	if i0 != $i5 goto $r21 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String[] parseRawURLToArrays(java.lang.String,int)>(r0, i0);	$r21 = staticinvoke <org.apache.dubbo.common.URLStrParser: java.lang.String[] parseRawURLToArrays(java.lang.String,int)>(r0, i0);	$i1 = lengthof $r21;	if $i1 > 1 goto r1 = $r21[0];	$r16 = <org.apache.dubbo.registry.support.CacheableFailbackRegistry: org.apache.dubbo.common.logger.ErrorTypeAwareLogger logger>;	$r22 = new java.lang.StringBuilder;	specialinvoke $r22.<java.lang.StringBuilder: void <init>()>();	$r17 = virtualinvoke $r22.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>("Received url without any parameters ");	$r18 = virtualinvoke $r17.<java.lang.StringBuilder: java.lang.StringBuilder append(java.lang.String)>(r0);	$r19 = virtualinvoke $r18.<java.lang.StringBuilder: java.lang.String toString()>();	interfaceinvoke $r16.<org.apache.dubbo.common.logger.ErrorTypeAwareLogger: void warn(java.lang.String,java.lang.String,java.lang.String,java.lang.String)>("1-5", "", "", $r19);	$r20 = staticinvoke <org.apache.dubbo.common.url.component.DubboServiceAddressURL: org.apache.dubbo.common.url.component.DubboServiceAddressURL valueOf(java.lang.String,org.apache.dubbo.common.URL)>(r0, r13);	return $r20
;block_num 3